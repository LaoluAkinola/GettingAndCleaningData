# Introduction 
This describes how the run_analysis.R script works and includes a code book describing the variables in the final output of the script. The script was used to clean the UCI Human Activity Recognition Using Smartphones Data Set Version 1.0. 

# How it Works
The script does the following.
## Reads
* Reads the measurement data used for the test and training data sets from "./UCI HAR Dataset/test/X_test.txt" and "./UCI HAR Dataset/train/X_train.txt", respectively.
* Reads the activity labels for the test and training data sets from "./UCI HAR Dataset/test/y_test.txt" and "./UCI HAR Dataset/train/y_train.txt". Thi
* Reads the Subject data which identifies the subject who performed the activity in each of row of the test and training data. These were read from "./UCI HAR Dataset/test/subject_test.txt" and  "./UCI HAR Dataset/train/subject_train.txt".
* Reads the activity names that maps the integers used as activity labels to names. Some text processing to remove the was done to extract just the names. The activity names were read from "./UCI HAR Dataset/activity_labels.txt".
* Reads the "features" which correspond to the variable names for the test and training data sets previously read. The features were read from  "./UCI HAR Dataset/features.txt".

## Merges and Subsets
The script then proceeds to merge the test and training data and using the features already read,  as the column names for the merged data. Of interest was the mean and standard deviation of each measurement. To extract only these measurements from the merged data, columns whose names matched "mean()" or "std()" were captured and used as argument to dplyr's select(). 
the activity labels for the test and training data as well as the subjects in the test and training data. Finally, Subject data and Activity Labels were added as columns to the merged data. 

## Makes Meaningful Variable Names
Each feature was given a default variable name as described in "features_info.txt". To make a meaningful variable name, first the type statistic and direction of the signal contained in the variable is extracted from the default variable name. After this,signal variable name are extracted. These are stored in 'statistic', and 'var'. A new variable name is then formed by concatenating statistic, an underscore and var in that order. The column names of the merged data from Merging and Subsetting is then updated with the result from the concatenation. 

## Creates the Second Tidy Data
The resulting data set from the previous step is then grouped by Subject and Activity before the summarise_all() function is used to find the average of each variable. The result is a data set with the average of each variable, for each activity and each subject. This is finally written to .txt file.
