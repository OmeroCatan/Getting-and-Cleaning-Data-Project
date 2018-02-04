# Codebook for Getting and Cleaning Data Coursera Project
## Description
This is the codebook outlining additional information about the data, created variables 
and actions performed to obtain the desired tidy data set; completing the project’s objective.
## Source Data
The data was pulled from UMI Machine Learning Repository and was collected using accelerometers from the Samsung Galaxy S smartphone. 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
## Data Set Information
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Pulled from The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. 
Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing 
a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial 
linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to 
label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected 
for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width 
sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and 
body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational 
force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, 
a vector of features was obtained by calculating variables from the time and frequency domain.
## Attribute Information
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

For each record in the dataset it is provided: 
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment. 
## Importing Data
After downloading the required R packages and setting the working directory, I read all the files listed below into tables.

Variables:

train1 – X_train.txt

train2 – y_train.txt

train3 – subject_train.txt

test1 – X_test.txt

test2 – y_test.txt

test3 – subject_test.txt

featurefile – features.txt

actitityLabelfile – activity_Labels.txt

## Review Provided Data
Before moving forward, I read through the provided ReadMe, Train, Test, Features and Activity files. 
I noticed that the "X" files related to the features of measurement, the "y" files to the activity being performed, and the "subject" files to the person performing said action.

## Data Combination
I combined the x, y, and subject data for both the test and training sets and then created one data set compiling all the data together.

Variables:

features - combination of X

activity - combination of y

subject - combination of subject

ActivityID - names for activity variable

SubjectID - names for subject variable

completeset - combined data set including the X, y and subject data from both training and testing

## Pull Only Mean and Standard Deviation Columns
I utilized the grep function to pull only the mean and standard deviation columns from the original features provided.

Variables:

mean_and_std_only – only the mean and standard deviation data

mean_and_std - assigned the names SubjectID and ActivityID as column labels 

newdata – data set of only mean and standard deviation including the new column names referenced above

## Apply Descriptive Names to the Columns
First I pulled the names from the original labels file and then utilized the gsub function to change the abbreviations to full names based on the information found in the source files.

## Create Tidy Data
I used the aggregate function to create a tidy data set as instruction in the project description and printed it to the directory of my choosing.

