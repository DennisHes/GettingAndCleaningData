Getting And Cleaning Data
===================

run_Analysis.R

In the first step the script starts with loading the neccessary packages into the library, assumming they are already installed.
In the second step the activitylabels are loaded into the activityLabels dataframe so they can be linked to the dataset later.
In the third step the test datasets with the data, the activitylabels and the subjects are loaded and joined into one dataframe with cbind. The activitylabels are joined with their description before joining them to the data. All datasets that will not be used later are removed.
In the fourth step the code applied to the test dataset is repeated for the training dataset.
In the fith step rbind is used to join the test and training data and the appropriate columns are selected and renamed.
In the sixth step melt is used to convert all columns to a variable with a measure.
in the last step this data is summarized to calculate the average for each measurement per subject and activity
