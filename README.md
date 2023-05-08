# Ember-IO Experiments

Details for running Ember-IO and reproduction of our results are presented in this repo.


Scripts are included to allow fuzzing of the tested binaries (inside the *Fuzzing* folder), and execute crashes observed in our tests. Inputs reproducing previously known crashes are included in the *Crashes* folder. Inputs for newly discovered crashes are contained in the *New Crashes* folder. These scripts depend on having Ember-IO installed from our [main repository](https://github.com/Ember-IO/Ember-IO-Fuzzing). Please set the *EMBER_BASE_DIR* environment variable with ``export EMBER_BASE_DIR=/path/to/Ember-IO-Fuzzing`` (Substituting the path with the location your installed Ember-IO) in order to use the scripts included in this repo.


If you encounter any problems, please open an issue.
