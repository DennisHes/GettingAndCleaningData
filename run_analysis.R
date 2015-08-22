library(dplyr)
library(data.table)
library(reshape)

#create dataset with activitylabeldescriptions to join with train and test set later
filenameActivityLabels <- "UCI HAR Dataset\\activity_labels.txt"
activityLabels <- read.table(filenameActivityLabels)
colnames(activityLabels)=c("activityLabelID","activityDescription")

#filenames testset
filetest_data <- "UCI HAR Dataset\\test\\X_test.txt"
filetest_activityLabelID <- "UCI HAR Dataset\\test\\y_test.txt"
filetest_subjectID <- "UCI HAR Dataset\\test\\subject_test.txt"

##join activityLabelID and subjectID with data
  #read data file
  test_data <- read.table(filetest_data)
  ds_test_data <- tbl_df(test_data)
  rm(test_data)
  #read activityLabelID file
  test_activityLabelID <- read.table(filetest_activityLabelID)
  ds_test_activityLabelID <- tbl_df(test_activityLabelID)
  rm(test_activityLabelID)
  colnames(ds_test_activityLabelID)[1]="activityLabelID"
  #join ActivityLabelNames
  ds_test_activityLabelID<- left_join(ds_test_activityLabelID, activityLabels, by="activityLabelID")
  #read subjectID file
  test_subjectID <- read.table(filetest_subjectID)
  ds_test_subjectID <- tbl_df(test_subjectID)
  rm(test_subjectID)
  colnames(ds_test_subjectID)[1]="subjectID"
  # put all test sets in one set
  test<- cbind(ds_test_subjectID, ds_test_activityLabelID, ds_test_data)
  rm(ds_test_subjectID)
  rm(ds_test_activityLabelID)
  rm(ds_test_data)

#filenames trainset
filetrain_data <- "UCI HAR Dataset\\train\\X_train.txt"
filetrain_activityLabelID <- "UCI HAR Dataset\\train\\y_train.txt"
filetrain_subjectID <- "UCI HAR Dataset\\train\\subject_train.txt"

##join activityLabelID and subjectID with data
  #read data file
  train_data <- read.table(filetrain_data)
  ds_train_data <- tbl_df(train_data)
  rm(train_data)
  #read activityLabelID file
  train_activityLabelID <- read.table(filetrain_activityLabelID)
  ds_train_activityLabelID <- tbl_df(train_activityLabelID)
  rm(train_activityLabelID)
  colnames(ds_train_activityLabelID)[1]="activityLabelID"
  #join ActivityLabelNames
  ds_train_activityLabelID<- left_join(ds_train_activityLabelID, activityLabels, by="activityLabelID")
  #read subjectID file
  train_subjectID <- read.table(filetrain_subjectID)
  ds_train_subjectID <- tbl_df(train_subjectID)
  rm(train_subjectID)
  colnames(ds_train_subjectID)[1]="subjectID"
  # put all train sets in one set
  train<- cbind(ds_train_subjectID, ds_train_activityLabelID, ds_train_data)
  rm(ds_train_subjectID)
  rm(ds_train_activityLabelID)
  rm(ds_train_data)

# join train set and test set into 1 dataset
dataset <- rbind(test, train)
rm(test)
rm(train)

#select appropriate columns
dataset <- select(dataset, subjectID, activityDescription, V1:V6, V41:V46, V81:V86, V121:V126
                  , V161:V166, V201, V202, V214, V215, V227, V228,V240, V241,V253, V254, V266:V271
                  , V345:V350, V424:V429, V503, V504, V516, V517, V529, V530, V542, V543)

# rename columns
colnames(dataset) = c("subjectID", "activityDescription", "tBodyAccMeanX", "tBodyAccMeanY", "tBodyAccMeanZ"
                     , "tBodyAccStandardDeviationX", "tBodyAccStandardDeviationY", "tBodyAccStandardDeviationZ"
                     , "tGravityAccMeanX", "tGravityAccMeanY", "tGravityAccMeanZ", "tGravityAccStandardDeviationX"
                     , "tGravityAccStandardDeviationY", "tGravityAccStandardDeviationZ", "tBodyAccJerkMeanX"
                     , "tBodyAccJerkMeanY", "tBodyAccJerkMeanZ", "tBodyAccJerkStandardDeviationX"
                     , "tBodyAccJerkStandardDeviationY", "tBodyAccJerkStandardDeviationZ", "tBodyGyroMeanX"
                     , "tBodyGyroMeanY", "tBodyGyroMeanZ", "tBodyGyroStandardDeviationX"
                     , "tBodyGyroStandardDeviationY", "tBodyGyroStandardDeviationZ", "tBodyGyroJerkMeanX"
                     , "tBodyGyroJerkMeanY", "tBodyGyroJerkMeanZ", "tBodyGyroJerkStandardDeviationX"
                     , "tBodyGyroJerkStandardDeviationY", "tBodyGyroJerkStandardDeviationZ", "tBodyAccMagMean"
                     , "tBodyAccMagStandardDeviation", "tGravityAccMagMean", "tGravityAccMagStandardDeviation"
                     , "tBodyAccJerkMagMean", "tBodyAccJerkMagStandardDeviation", "tBodyGyroMagMean"
                     , "tBodyGyroMagStandardDeviation", "tBodyGyroJerkMagMean", "tBodyGyroJerkMagStandardDeviation"
                     , "fBodyAccMeanX", "fBodyAccMeanY", "fBodyAccMeanZ", "fBodyAccStandardDeviationX"
                     , "fBodyAccStandardDeviationY", "fBodyAccStandardDeviationZ", "fBodyAccJerkMeanX"
                     , "fBodyAccJerkMeanY", "fBodyAccJerkMeanZ",  "fBodyAccJerkStandardDeviationX"
                     , "fBodyAccJerkStandardDeviationY", "fBodyAccJerkStandardDeviationZ", "fBodyGyroMeanX"
                     , "fBodyGyroMeanY", "fBodyGyroMeanZ", "fBodyGyroStandardDeviationX"
                     , "fBodyGyroStandardDeviationY", "fBodyGyroStandardDeviationZ", "fBodyAccMagMean"
                     , "fBodyAccMagStandardDeviation", "fBodyBodyAccJerkMagMean"
                     , "fBodyBodyAccJerkMagStandardDeviation", "fBodyBodyGyroMagMean"
                     , "fBodyBodyGyroMagStandardDeviation", "fBodyBodyGyroJerkMagMean"
                     ,  "fBodyBodyGyroJerkMagStandardDeviation")

#create second dataset with average per subject / activity for eact variable
datasetMelt <- melt(dataset
                    , id=c("subjectID", "activityDescription")
                    , measure=c("tBodyAccMeanX", "tBodyAccMeanY", "tBodyAccMeanZ", "tBodyAccStandardDeviationX"
                                , "tBodyAccStandardDeviationY", "tBodyAccStandardDeviationZ", "tGravityAccMeanX"
                                , "tGravityAccMeanY", "tGravityAccMeanZ", "tGravityAccStandardDeviationX"
                                , "tGravityAccStandardDeviationY", "tGravityAccStandardDeviationZ"
                                , "tBodyAccJerkMeanX", "tBodyAccJerkMeanY", "tBodyAccJerkMeanZ"
                                , "tBodyAccJerkStandardDeviationX", "tBodyAccJerkStandardDeviationY"
                                , "tBodyAccJerkStandardDeviationZ", "tBodyGyroMeanX", "tBodyGyroMeanY"
                                , "tBodyGyroMeanZ", "tBodyGyroStandardDeviationX", "tBodyGyroStandardDeviationY"
                                , "tBodyGyroStandardDeviationZ", "tBodyGyroJerkMeanX", "tBodyGyroJerkMeanY"
                                , "tBodyGyroJerkMeanZ", "tBodyGyroJerkStandardDeviationX"
                                , "tBodyGyroJerkStandardDeviationY", "tBodyGyroJerkStandardDeviationZ"
                                , "tBodyAccMagMean", "tBodyAccMagStandardDeviation", "tGravityAccMagMean"
                                , "tGravityAccMagStandardDeviation", "tBodyAccJerkMagMean"
                                , "tBodyAccJerkMagStandardDeviation", "tBodyGyroMagMean"
                                , "tBodyGyroMagStandardDeviation", "tBodyGyroJerkMagMean"
                                , "tBodyGyroJerkMagStandardDeviation", "fBodyAccMeanX", "fBodyAccMeanY"
                                , "fBodyAccMeanZ", "fBodyAccStandardDeviationX", "fBodyAccStandardDeviationY"
                                , "fBodyAccStandardDeviationZ", "fBodyAccJerkMeanX", "fBodyAccJerkMeanY"
                                , "fBodyAccJerkMeanZ",  "fBodyAccJerkStandardDeviationX"
                                , "fBodyAccJerkStandardDeviationY", "fBodyAccJerkStandardDeviationZ"
                                , "fBodyGyroMeanX", "fBodyGyroMeanY", "fBodyGyroMeanZ"
                                , "fBodyGyroStandardDeviationX", "fBodyGyroStandardDeviationY"
                                , "fBodyGyroStandardDeviationZ", "fBodyAccMagMean", "fBodyAccMagStandardDeviation"
                                , "fBodyBodyAccJerkMagMean", "fBodyBodyAccJerkMagStandardDeviation"
                                , "fBodyBodyGyroMagMean", "fBodyBodyGyroMagStandardDeviation"
                                , "fBodyBodyGyroJerkMagMean",  "fBodyBodyGyroJerkMagStandardDeviation"))
groupedDatasetMelt <- group_by(datasetMelt, subjectID, activityDescription)
rm(datasetMelt)
datasetWithAverages <- summarize(groupedDatasetMelt, average = mean(value))
rm(groupedDatasetMelt)
