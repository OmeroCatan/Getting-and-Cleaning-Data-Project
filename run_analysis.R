# Setting Working Directory

setwd("C:/Users/omero_000/Desktop/DataScience")
getwd()

# Install and Load Packages

install.packages("data.table")
install.packages("plyr")
install.packages("dplyr")

library(data.table)
library(plyr)
library(dplyr)

# Download and Unzip the Files
 
if(!file.exists("./datacleaningproject"))
  {dir.create("./datacleaningproject")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

download.file(url = fileUrl, destfile = dest)
dest <- "C:/Users/omero_000/Desktop/DataScience/datacleaninproject.zip"
dest1 <- "C:/Users/omero_000/Desktop/DataScience/datacleaningproject/data"
unzip(zipfile = dest, exdir = dest1)

# Read the Train, Test, Features, and Activity Files

train1 <- read.table("C:/Users/omero_000/Desktop/DataScience/datacleaningproject/data/UCI HAR Dataset/train/X_train.txt")
train2 <- read.table("C:/Users/omero_000/Desktop/DataScience/datacleaningproject/data/UCI HAR Dataset/train/y_train.txt")
train3 <- read.table("C:/Users/omero_000/Desktop/DataScience/datacleaningproject/data/UCI HAR Dataset/train/subject_train.txt")

test1 <- read.table("C:/Users/omero_000/Desktop/DataScience/datacleaningproject/data/UCI HAR Dataset/test/X_test.txt")
test2 <- read.table("C:/Users/omero_000/Desktop/DataScience/datacleaningproject/data/UCI HAR Dataset/test/y_test.txt")
test3 <- read.table("C:/Users/omero_000/Desktop/DataScience/datacleaningproject/data/UCI HAR Dataset/test/subject_test.txt")

featurefile <- read.table("C:/Users/omero_000/Desktop/DataScience/datacleaningproject/data/UCI HAR Dataset/features.txt")

activityLabelfile <- read.table("C:/Users/omero_000/Desktop/DataScience/datacleaningproject/data/UCI HAR Dataset/activity_Labels.txt")

# Assign Column Names to the Files

colnames(train1) <- featurefile[,2]
colnames(train2) <- "ID_of_Activity"
colnames(train3) <- "ID_of_Subject"

colnames(test1) <- featurefile[,2]
colnames(test2) <- "ID_of_Activity"
colnames(test3) <- "ID_of_Subject"

colnames(activityLabelfile) <- c("ID_of_Activity", "Type_of_Activity")

# Combine the Test and Training Files into One Data Set

trainingset <- cbind(train1, train2, train3)
testingset <- cbind(test1, test2, test3)
completeset <- rbind(trainingset, testingset)

# Pull only the Mean and Std Data Required for the Assignment

completesetColNames <- colnames(completeset)
DefinitionVector <- (grepl("ID_of_Activity", completesetColNames) | 
                     grepl("ID_of_Subject", completesetColNames) | 
                     grepl("mean", completesetColNames) | 
                     grepl("std", completesetColNames))
Mean_and_Std <- completeset[, DefinitionVector == TRUE]

# Apply Descriptive Names to the Columns

names(completeset)<- gsub("^t", "Time", names(completeset))
names(completeset)<- gsub("^f", "Frequency", names(completeset))
names(completeset)<- gsub("Acc", "Accelerometer", names(completeset)) 
names(completeset)<- gsub("Gyro", "Gyroscope", names(completeset)) 
names(completeset)<- gsub("Mag", "Magnitude", names(completeset))
names(completeset)<- gsub("BodyBody", "Body", names(completeset))

# Create Second "Tidy" Dataset

TidyData <- aggregate(.~ID_of_Subject + ID_of_Activity, completeset, mean)
TidyData <- TidyData[order(TidyData$ID_of_Subject, TidyData$ID_of_Activity),]

# Print Tidy Dataset

setwd("C:/Users/omero_000/Desktop/DataScience/datacleaningproject")
write.table(TidyData, "TidyData.txt", row.names = FALSE)
