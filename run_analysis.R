# Set working directory

setwd("C:/Users/omero_000/Desktop/DataScience")
getwd()

# Install and load packages

install.packages("data.table")
install.packages("plyr")
install.packages("dplyr")

library(data.table)
library(plyr)
library(dplyr)

# Download and unzip the files
 
if(!file.exists("./datacleaningproject"))
  {dir.create("./datacleaningproject")}

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

dest <- "C:/Users/omero_000/Desktop/DataScience/datacleaninproject.zip"
download.file(url = fileUrl, destfile = dest)

dest1 <- "C:/Users/omero_000/Desktop/DataScience/datacleaningproject/data"
unzip(zipfile = dest, exdir = dest1)

# Read the Train, Test, Features, and Activity files

train1 <- read.table("C:/Users/omero_000/Desktop/DataScience/datacleaningproject/data/UCI HAR Dataset/train/X_train.txt")
train2 <- read.table("C:/Users/omero_000/Desktop/DataScience/datacleaningproject/data/UCI HAR Dataset/train/y_train.txt")
train3 <- read.table("C:/Users/omero_000/Desktop/DataScience/datacleaningproject/data/UCI HAR Dataset/train/subject_train.txt")

test1 <- read.table("C:/Users/omero_000/Desktop/DataScience/datacleaningproject/data/UCI HAR Dataset/test/X_test.txt")
test2 <- read.table("C:/Users/omero_000/Desktop/DataScience/datacleaningproject/data/UCI HAR Dataset/test/y_test.txt")
test3 <- read.table("C:/Users/omero_000/Desktop/DataScience/datacleaningproject/data/UCI HAR Dataset/test/subject_test.txt")

featurefile <- read.table("C:/Users/omero_000/Desktop/DataScience/datacleaningproject/data/UCI HAR Dataset/features.txt")

activityLabelfile <- read.table("C:/Users/omero_000/Desktop/DataScience/datacleaningproject/data/UCI HAR Dataset/activity_Labels.txt")

# Analyze given data
# Read the ReadMe, Train, Test, Features, and Activity files
# The Y files hold the labels of activity, the X holds the features and the subject is the person performing the activity

# Combine the X, y, and subject data between the test and training sets

features <- rbind(train1, test1)
activity <- rbind(train2, test2)
subject <- rbind(train3, test3)

# Name the new data sets so they can be called. The features is pulled from provided data.

names(features) <- featurefilename$V2
names(activity) <- “ActivityID”
names(subject) <- “SubjectID”

# Create one data set

completeset <- cbind(features,activity,subject)

# Pull only the Mean and Std Data required for the assignment
# Mean and Std attributes to the features (X) data

mean_and_std_only <- featurefile$V2[grep("mean\\(\\)|std\\(\\)", featurefile$V2)]
mean_and_std <- c(as.character(mean_and_std_only), “SubjectID”, “ActivityID”)
newdata <- subset(completeset, select = mean_and_std)

# Apply descriptive activity names

newdata$ActivityID<- activityLabelfile[newdata$ActivityID, 2]

names(completeset)<- gsub("^t", "Time", names(completeset))
names(completeset)<- gsub("^f", "Frequency", names(completeset))
names(completeset)<- gsub("Acc", "Accelerometer", names(completeset)) 
names(completeset)<- gsub("Gyro", "Gyroscope", names(completeset)) 
names(completeset)<- gsub("Mag", "Magnitude", names(completeset))
names(completeset)<- gsub("BodyBody", "Body", names(completeset))

# Create and Print Second "Tidy" Dataset

TidyData <- aggregate(.~SubjectID + ActivityID, newdata, mean)

setwd("C:/Users/omero_000/Desktop/DataScience/datacleaningproject")
write.table(TidyData, "TidyData.txt", row.names = FALSE)
