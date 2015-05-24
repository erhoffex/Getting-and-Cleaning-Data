setwd("~/Desktop/WD data analysis") # sets working directory

# dowbloads dataset and saves it to wd
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile="./Data/Dataset.zip", method="curl")

# unzips dataset
unzip(zipfile="./Data/Dataset.zip",exdir="./Data")

# lists the files in the "UCI HAR Dataset" folder
files<-list.files("./Data/UCI HAR Dataset", recursive=TRUE)
files

# read the README.text file

# reads the test datasets and explores dimensions
X_test <- read.table("~/Desktop/WD data analysis/Data/UCI HAR Dataset/test/X_test.txt", quote="\"")
View(X_test)
activity_test <- read.table("~/Desktop/WD data analysis/Data/UCI HAR Dataset/test/y_test.txt", quote="\"")
subjets_test <- read.table("~/Desktop/WD data analysis/Data/UCI HAR Dataset/test/subject_test.txt", quote="\"")

# merges the test datasets  by columns
test_DB <- cbind(X_test, activity_test, subject_test)

# reads the train datasets and explores dimensions
X_train <- read.table("~/Desktop/WD data analysis/Data/UCI HAR Dataset/train/X_train.txt", quote="\"")
activity_train <- read.table("~/Desktop/WD data analysis/Data/UCI HAR Dataset/train/y_train.txt", quote="\"")
subject_train <- read.table("~/Desktop/WD data analysis/Data/UCI HAR Dataset/train/subject_train.txt", quote="\"")

# merges the test datasets  by columns
train_BD <- cbind (X_train, activity_train, subject_train)

# merges the train and the test datasets by rows
combinedDF<- rbind(train_BD, test_DB)

# Assigns column names to the combinedDF

# reads the feature data set with the names for col 1:561 
features <- read.table("~/Desktop/WD data analysis/Data/UCI HAR Dataset/features.txt", quote="\"")
# converts names into character verctor
features.names <- as.character (features$V2)
# assings col names
colnames(combinedDF) <- c(features.names, "Activity", "Subject")

# checks result : 10299 obs. of 563 variables with col names
summary(combinedDF)

# extracts two subsets: mean and std measurements AND subject+activity
subset1 <- combinedDF[, grep("mean\\(\\)|std\\(\\)", features.names)]
subset2 <- combinedDF[, 562:563]

# combines into a single dataframe
data_means_std <-cbind(subset1,subset2)

# Assings activity names to activity codes

# creates vector of factor and transforms into dataframe
activity <-factor (data_means_std[,67], levels=1:6, labels=labels$V2)
activity <- as.character(activity)
activityDF <- data.frame(activity, row.names=NULL)

# replaces column 67 in data_means_std using the dplyr package
library (dplyr)
dataset <-tbl_df(data_means_std)
activity.2 <- tbl_df(activityDF)
data_3 <- cbind (dataset, activity.2)
data.with.activity <- select(data_3, (1:66), -67, 69, 68)

# Checks result: 10299 observations ofr 68 variables, the last two being activity and Subject
head (data.with.activity)

# Replaces col names using full descriptive names

names(data.with.activity)<-gsub("^t", "time", names(data.with.activity))
names(data.with.activity)<-gsub("^f", "frequency", names(data.with.activity))
names(data.with.activity)<-gsub("Acc", "Accelerometer", names(data.with.activity))
names(data.with.activity)<-gsub("Gyro", "Gyroscope", names(data.with.activity))
names(data.with.activity)<-gsub("Mag", "Magnitude", names(data.with.activity))
names(data.with.activity)<-gsub("BodyBody", "Body", names(data.with.activity))
names(data.with.activity)
names(data.with.activity)<-gsub("activity", "Activity", names(data.with.activity))

# Checks results and simplifies dataset name
names(data.with.activity)
DataFinal <- data.with.activity

# Groups by activity and subject and applies mean function to the rest of the variables
Data2<-aggregate(. ~Subject + Activity, DataFinal, mean)

# Check results: Data2 has 180 observations of 68 variables
View(Data2)
Data.tidy <- Data2

# saves Data.tidy into a separate txt.file in Dataset folder in wd
write.table(Data.tidy, file="./Dataset/tidydata.txt", row.name=FALSE)
