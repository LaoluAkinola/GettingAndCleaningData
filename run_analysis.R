library(readr)
library(dplyr)
library(stringr)

# load test data
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
# load training data
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
# load activity label for test data
actvtyLbl_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
# load activity label for train data
actvtyLbl_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
# load subject data for test data
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
# load subject data for train data
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
# load activity_labels factors
activity_labels <- readLines("./UCI HAR Dataset/activity_labels.txt")
activity <- gsub("[0-9]", "", activity_labels)
activity <- gsub(" ", "", activity)
# load features
features <- readLines("./UCI HAR Dataset/features.txt")

# combine data
combinedData <- rbind(X_train, X_test)
# combine labels
combinedLabels <- rbind(actvtyLbl_train, actvtyLbl_test)
# combine subjects
combinedSubjects <- rbind(subject_train, subject_test)

# rename columns with features
colnames(combinedData) <- features;

# Extract mean and standard deviation
tbl_combinedData <- tbl_df(combinedData)
pattern <- "mean()|std()"
toSelect <- grep(pattern, features, perl = TRUE)
meanstdData <- select(tbl_combinedData, toSelect)

# Add activity labels
meanstdData <- mutate(meanstdData, Activity = factor(combinedLabels[,], labels = activity))
# Add subject
meanstdData <- mutate(meanstdData, Subject = as.factor(combinedSubjects[,]))

# Make Meaningful variable names 
statistic <- str_extract_all(names(meanstdData), "-(.*)", simplify = TRUE)
statistic <- gsub("\\W", "", statistic)

#direction <- str_extract_all(names(meanstdData), "-[X|Y|Z]", simplify = TRUE)
#direction <- gsub("\\W", "", direction)

var <- str_extract(names(meanstdData), "[t|f](.*)-")
var <- gsub("-.*-", "", var)
var <- gsub("-", "", var)

#varname <- paste(direction,statistic,"_", var, sep = "")
varname <- paste(statistic,"_", var, sep = "")
varname <- gsub("^_", "", varname)
varname[length(varname) - 1] <- "Activity"
varname[length(varname)] <- "Subject"
colnames(meanstdData) <- varname


# Create second tidy data
secondTidyData <- group_by(meanstdData, Subject, Activity)
secondTidyData <- summarise_all(secondTidyData, mean)
write.table(secondTidyData, "tidyUCIHARDataset.txt", row.name = FALSE)