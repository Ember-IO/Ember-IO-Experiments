#!/bin/bash

qemu_params="./Drone.elf -sram_size 1024k -flash_size 52k -cpu cortex-m3 -sram2_base 0 -sram2_size 4k -machine embedded_fuzz"
bbl_file="./bbl_list.txt"

if [[ ! -f $EMBER_BASE_DIR/AFLplusplus/afl-fuzz ]]; then
  echo "Environment variable EMBER_BASE_DIR not set correctly? Exiting"
  exit
fi

if [ $# -ne 0 ]; then
  echo "Using $1 as the source of fuzzing campaign data"
  indir=$1
else
  indir="./output"
fi

indir="$indir/default"

if [ -d "./summary" ]; then
  echo "Summary folder already exists, please delete it"
  exit
fi

if [ ! -d "$indir/queue" ]; then
  echo "Couldn't find queue inside specified AFL output dir at $indir"
  exit
fi

mkdir summary
mkdir summary/queue
mkdir summary/crashes
mkdir summary/coverage

echo "Copying Crashes"
crashnum=0
for file in $(ls $indir/crashes/id*)
do
  cp $file "./summary/crashes/$crashnum"
  crashnum=`expr $crashnum + 1`
done

echo "Copying Queue"
queuenum=$(ls $indir/queue/id* | grep 'orig' | wc -l)
for file in $(ls $indir/queue/id* | grep -v 'orig')
do
  filename=$(printf "%06d" $queuenum)
  cp $file "./summary/queue/$filename"
  queuenum=`expr $queuenum + 1`
done

for file in $(ls summary/crashes)
do
  echo "Running crash file $file"
  out=$(eval "$EMBER_BASE_DIR/AFLplusplus/afl-qemu-trace -d exec -fuzz_input summary/crashes/$file -kernel $qemu_params 2>&1 | grep -e 'Trace' -e 'Chain' | tail -1")
  echo "0x${out:34:8} ${out:54}" >> summary/curCrashes
done

cat summary/curCrashes | sort | uniq > summary/uniqCrashes
rm summary/curCrashes

for input in $(ls summary/queue)
do
echo "Running input file $input of $queuenum"
$(eval "$EMBER_BASE_DIR/AFLplusplus/afl-qemu-trace -fuzz_input summary/queue/$input -kernel $qemu_params >/dev/null")
if [ $? -eq 0 ];
then
IFS=$'\n'
for l in $(eval "$EMBER_BASE_DIR/AFLplusplus/afl-qemu-trace -d exec -fuzz_input summary/queue/$input -kernel $qemu_params 2>&1 >/dev/null | grep '00000000/'")
do
  echo "0x${l:34:8}" >> summary/exec_bbl_list
done
else
  echo "Error in execution. Crashing input?"
fi

cat summary/exec_bbl_list | sort | uniq > summary/temp
rm summary/exec_bbl_list
if [[ -f "$bbl_file" ]]; then
  comm -12 ./summary/temp $bbl_file > summary/exec_bbl_list
  rm summary/temp
else
  mv summary/temp summary/exec_bbl_list
fi
cp summary/exec_bbl_list summary/coverage/$input
done
cat summary/exec_bbl_list | sort | uniq >| summary/uniq_bbl_execs
rm summary/exec_bbl_list

found_blocks=$(cat summary/uniq_bbl_execs | wc -l)

echo "Estimated blocks covered: $found_blocks"
