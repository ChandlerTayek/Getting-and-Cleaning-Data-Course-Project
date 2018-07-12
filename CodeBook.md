CodeBook.md

describes the variables, the data, and any transformations or work that you performed to clean up the data



## Data Location and Files
The data is scattered across multiple files and only a subset of all the files from [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) are used.

The following is a code snippet showing the different files used from the 'run_analysis.R' file:
```
train_path<- "./UCI HAR Dataset/train/X_train.txt"
test_path <- "./UCI HAR Dataset/test/X_test.txt"
features_path <- "./UCI HAR Dataset/features.txt"
label_train_path <- "./UCI HAR Dataset/train/y_train.txt"
label_test_path <- "./UCI HAR Dataset/test/y_test.txt"
subjects_train_path <- "./UCI HAR Dataset/train/subject_train.txt"
subjects_test_path <- "./UCI HAR Dataset/test/subject_test.txt"
activities_path <- "./UCI HAR Dataset/activity_labels.txt"
```

## Cleaning the Data
The idea here was to combine all of the information from the following files into a descriptive clean dataset. First all of the files are loaded into Tibbles, which are a special form of data frames from the 'Tibble' package. The features.txt file is used for naming all of the variables in the training and test sets. The features came with numbers in the front which were removed so that just the name of each variable could be used.

Next the  test set and training set are merged together placing one on top of the other. Following the merge the subject id as well as the activity that describes the observation were added as new variable columns at the beginning of our new big dataset.

## Extraction of Mean and Standard Deviation
The grep command is used to filter out all of the commands that are not the variables relating to the mean or standard deviation of the feature.

## Replace Activity Numbers With Descriptive Names
The activity data is given as a numbers. The final Tidy dataset takes the numbers and converts them to the descriptive activity name given by 'activity_labels.txt'

## Create a Sub Table of All the Averages for Each activity and Each Subject
A smaller table is created using the average of all of the observations using the group_by function from the `dplyr` package.

## Variables/Features
(The below paragraphs are taken straight from the features_info.txt)

"The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz.

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag).

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals).

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions."

### Actual Variables Found in the Tidy Dataset

- subject
  - The subject's unique IDs
    - Range: (1-30)
- activity.name
  - The action the subject is taking
    - possible values:
      - LAYING
      - SITTING
      - STANDING
      - WALKING
      - WALKING_DOWNSTAIRS
      - WALKING_UPSTAIRS
- timebodyacc.mean.x
- timebodyacc.mean.y
- timebodyacc.mean.z
- timebodyacc.standardDeviation.x
- timebodyacc.standardDeviation.y
- timebodyacc.standardDeviation.z
- timegravityacc.mean.x
- timegravityacc.mean.y
- timegravityacc.mean.z
- timegravityacc.standardDeviation.x
- timegravityacc.standardDeviation.y
- timegravityacc.standardDeviation.z
- timebodyaccjerk.mean.x
- timebodyaccjerk.mean.y
- timebodyaccjerk.mean.z
- timebodyaccjerk.standardDeviation.x
- timebodyaccjerk.standardDeviation.y
- timebodyaccjerk.standardDeviation.z
- timebodygyroscope.mean.x
- timebodygyroscope.mean.y
- timebodygyroscope.mean.z
- timebodygyroscope.standardDeviation.x
- timebodygyroscope.standardDeviation.y
- timebodygyroscope.standardDeviation.z
- timebodygyroscopejerk.mean.x
- timebodygyroscopejerk.mean.y
- timebodygyroscopejerk.mean.z
- timebodygyroscopejerk.standardDeviation.x
- timebodygyroscopejerk.standardDeviation.y
- timebodygyroscopejerk.standardDeviation.z
- timebodyaccmagnitude.mean
- timebodyaccmagnitude.standardDeviation
- timegravityaccmagnitude.mean
- timegravityaccmagnitude.standardDeviation
- timebodyaccjerkmagnitude.mean
- timebodyaccjerkmagnitude.standardDeviation
- timebodygyroscopemagnitude.mean
- timebodygyroscopemagnitude.standardDeviation
- timebodygyroscopejerkmagnitude.mean
- timebodygyroscopejerkmagnitude.standardDeviation
- frequencybodyacc.mean.x
- frequencybodyacc.mean.y
- frequencybodyacc.mean.z
- frequencybodyacc.standardDeviation.x
- frequencybodyacc.standardDeviation.y
- frequencybodyacc.standardDeviation.z
