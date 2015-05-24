# Getting-and-Cleaning-Data
 ## The raw data for this project were collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

 ## http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

 ## Here are the data for the project:

 ## https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

 ## The R script called run_analysis.R that does the following.

1. Dowloads the raw dataset into wd in RStudio
2. Unzips the folder
3. Lists the files
4. Reads the different sets of files
5. Merges the training and the test sets to create one data set.
6. Extracts only the measurements on the mean and standard deviation for each measurement.
7. Uses descriptive activity names to name the activities in the data set
8. Appropriately labels the data set with descriptive variable names.
9. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
10. Saves the output into a new folder 
