##
# Project; Getting and Cleaning Data Course Project
# Author: Chandler Tayek
# Dataset from: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
##

if(!dir.exists("./UCI HAR Dataset/")){
    
    download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "./motion.zip", mode='wb')
    unzip("./motion.zip")
    unlink("./motion.zip")
}

## Set the paths of relevant files
train_path<- "./UCI HAR Dataset/train/X_train.txt"
test_path <- "./UCI HAR Dataset/test/X_test.txt"
features_path <- "./UCI HAR Dataset/features.txt"
label_train_path <- "./UCI HAR Dataset/train/y_train.txt"
label_test_path <- "./UCI HAR Dataset/test/y_test.txt"
subjects_train_path <- "./UCI HAR Dataset/train/subject_train.txt"
subjects_test_path <- "./UCI HAR Dataset/test/subject_test.txt"
activities_path <- "./UCI HAR Dataset/activity_labels.txt"

## Read in the various tables
feature_names <- read_table(features_path, col_names = FALSE)
feature_names <- feature_names[[1]]
#Remove the numbers from the names
feature_names <- sub(pattern = "\\d+ ", replacement = "", x = feature_names)
subject_train_table <- read_table(subjects_train_path, col_names = "Subjects")
subject_test_table <- read_table(subjects_test_path, col_names="Subjects")
train_data <- read_table(train_path, col_names = feature_names)
train_labels <- read_table(label_train_path, col_names = "Activity")
test_data <- read_table(test_path, col_names = feature_names)
test_labels <- read_table(label_test_path, col_names = "Activity")
activities <- read_table(activities_path, col_names = FALSE)
activities <- select(activities, X2)


## 1.Merge the training and the test sets to create a single data set.-------------------------------
#Merge both the training and test set and call it merged_dataset
train_data <- bind_cols(train_data, train_labels)
train_data_and_subjects <- bind_cols(train_data, subject_train_table)
test_data <- bind_cols(test_data, test_labels)
test_data_and_subjects <- bind_cols(test_data, subject_test_table)
merged_dataset <- bind_rows(train_data_and_subjects, test_data_and_subjects)

## 2. Extracts only the measurements on the mean and standard deviation for each measurement.--------
names_of_mean_and_std <- names(select(merged_dataset, grep(pattern = "mean\\(\\)|std", x = names(merged_dataset))))
merged_cut_dataset <- select(merged_dataset, names_of_mean_and_std)
merged_cut_dataset_with_sub_act <- bind_cols(merged_dataset["Subjects"], merged_dataset["Activity"], merged_cut_dataset)


## 3.Uses descriptive activity names to name the activities in the data set.-------------------------
#Change the labels to describtive activities
merged_cut_dataset_with_sub_act["Activity"] <- sapply(select(merged_cut_dataset_with_sub_act, Activity), function(x){activities[x,]})


## 4. Appropriately labels the data set with descriptive variable names.-----------------------------
## The variable names without the numbers are appropriate names to use because of how
## short and descriptive they are.

## 5. From the data set in step 4, creates a second, independent tidy data 
##    set with the average of each variable for each activity and each subject. ---------------------
by_activity_sub <- merged_cut_dataset_with_sub_act %>% group_by(Activity, Subjects)
summ <- by_activity_sub %>% summarise_all(.funs = mean)

    
    
