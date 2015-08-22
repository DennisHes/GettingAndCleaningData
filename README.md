Getting And Cleaning Data
===================

run_Analysis.R

1. In the first step the script starts with loading the neccessary packages into the library, assumming they are already installed.
2. In the second step the activitylabels are loaded into the activityLabels dataframe so they can be linked to the dataset later.
3. In the third step the test datasets with the data, the activitylabels and the subjects are loaded and joined into one dataframe with cbind. The activitylabels are joined with their description before joining them to the data. All datasets that will not be used later are removed.
4. In the fourth step the code applied to the test dataset is repeated for the training dataset.
5. In the fith step rbind is used to join the test and training data and the appropriate columns are selected and renamed.
6. In the sixth step melt is used to convert all columns to a variable with a measure.
7. In the last step this data is summarized to calculate the average for each measurement per subject and activity
