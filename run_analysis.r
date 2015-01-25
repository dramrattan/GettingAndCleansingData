run_analysis <- function (){

##LOAD THE NEEDED LIBRARY'S
library(plyr)
library(reshape)

##START STEP 1
##STORE THE FILE PATH'S NEEDED FOR THE ANALYSIS
featuresFile <- paste(getwd(),"/features.txt",sep="")
x_testFile <- paste(getwd(),"/test/X_test.txt",sep="")
x_trainFile <- paste(getwd(),"/train/X_train.txt",sep="")
subject_testFile <- paste(getwd(),"/test/subject_test.txt",sep="")
subject_trainFile <- paste(getwd(),"/train/subject_train.txt",sep="")
y_testFile <- paste(getwd(),"/test/y_test.txt",sep="")
y_trainFile <- paste(getwd(),"/train/y_train.txt",sep="")
activity_File <- paste(getwd(),"/activity_labels.txt",sep="")

##LOAD THE FEATURES TO A TABLE
featuresTable <- read.table(featuresFile)
features <- featuresTable[,"V2"]

#LOAD THE MAPPING FROM ACTIVITY CODES TO ACTIVITY DESCRIPTION
activity_data <- read.table(activity_File)

##LOAD THE TEST DATA, INCLUDING VARIABLES, PREDICTION, AND THE SUBJECTS
x_testData <- read.table(x_testFile,col.names=features)
y_testData <- read.table(y_testFile,col.names=c("Activity"))
subject_testData <- read.table(subject_testFile,col.names=c("Subject"))

##COMBINE TEST DATA
testData <- cbind(x_testData,y_testData,subject_testData)

##LOAD THE TRAIN DATA, INCLUDING VARIABLES, PREDICTION, AND THE SUBJECTS
x_trainData <- read.table(x_trainFile,col.names=features)
y_trainData <- read.table(y_trainFile,col.names=c("Activity"))
subject_trainData <- read.table(subject_trainFile,col.names=c("Subject"))

##COMBINE TRAIN DATA
trainData <- cbind(x_trainData,y_trainData,subject_trainData)

##COMBINE THE TEST AND TRAIN DATA
data <- rbind(testData,trainData)
##END STEP 1

##START STEP 3
#COMBINE THE DATA AND ACTIVITY FILE,
##SO THAT A DESCRIPTIVE ACTIVITY CAN BE OUTPUT LATER
data <- merge(data, activity_data,by.x="Activity",by.y="V1")
##END STEP 3


##START STEP 2
##CREATE CHARACTER VECTOR WITH FEATURE NAMES CONTAING mean OR std
mnStd <- make.names(features[grepl("mean|std",as.character(features))])
##ADD ACTIVITY VARIABLES
mnStd <- c(mnStd,"V2","Subject")
##SUBSET THE DATA USING THE mean/std VECTOR
mnStdData <- subset(data,,mnStd)
##END STEP 2

##START STEP 4
##RENAME VARIABLE NAMES TO MORE MEANINGFUL AND DESCRIPTIVE NAMES
mnStdData <- rename(mnStdData,c(
  "tBodyAcc.mean...X"="Mean Linear Body Acceleration By Time In The X Direction",
  "tBodyAcc.mean...Y"="Mean Linear Body Acceleration By Time In The Y Direction",
  "tBodyAcc.mean...Z"="Mean Linear Body Acceleration By Time In The Z Direction",
  "tBodyAcc.std...X"="Standard Deviation of the Linear Body Acceleration By Time In The X Direction",
  "tBodyAcc.std...Y"="Standard Deviation of the Linear Body Acceleration By Time In The Y Direction",
  "tBodyAcc.std...Z"="Standard Deviation of the Linear Body Acceleration By Time In The Z Direction",
  "tGravityAcc.mean...X"="Mean Gravity Acceleration By Time In The X Direction",
  "tGravityAcc.mean...Y"="Mean Gravity Acceleration By Time In The Y Direction",
  "tGravityAcc.mean...Z"="Mean Gravity Acceleration By Time In The Z Direction",
  "tGravityAcc.std...X"="Standard Deviation of the Gravity Acceleration By Time In The X Direction",
  "tGravityAcc.std...Y"="Standard Deviation of the Gravity Acceleration By Time In The Y Direction",
  "tGravityAcc.std...Z"="Standard Deviation of the Gravity Acceleration By Time In The Z Direction",
  "tBodyAccJerk.mean...X"="Mean Linear Body Jerking Acceleration By Time In The X Direction",
  "tBodyAccJerk.mean...Y"="Mean Linear Body Jerking Acceleration By Time In The Y Direction",
  "tBodyAccJerk.mean...Z"="Mean Linear Body Jerking Acceleration By Time In The Z Direction",
  "tBodyAccJerk.std...X"="Standard Deviation of the Linear Body Jerking Acceleration By Time In The X Direction",
  "tBodyAccJerk.std...Y"="Standard Deviation of the Linear Body Jerking Acceleration By Time In The Y Direction",
  "tBodyAccJerk.std...Z"="Standard Deviation of the Linear Body Jerking Acceleration By Time In The Z Direction",
  "tBodyGyro.mean...X"="Mean Angular Velocity By Time In The X Direction",
  "tBodyGyro.mean...Y"="Mean Angular Velocity By Time In The Y Direction",
  "tBodyGyro.mean...Z"="Mean Angular Velocity By Time In The Z Direction",
  "tBodyGyro.std...X"="Standard Deviation of the Angular Velocity By Time In The X Direction",
  "tBodyGyro.std...Y"="Standard Deviation of the Angular Velocity By Time In The Y Direction",
  "tBodyGyro.std...Z"="Standard Deviation of the Angular Velocity By Time In The Z Direction",
  "tBodyGyroJerk.mean...X"="Mean Angular Velocity Jerking By Time In The X Direction",
  "tBodyGyroJerk.mean...Y"="Mean Angular Velocity Jerking By Time In The Y Direction",
  "tBodyGyroJerk.mean...Z"="Mean Angular Velocity Jerking By Time In The Z Direction",
  "tBodyGyroJerk.std...X"="Standard Deviation of the Angular Velocity Jerking By Time In The X Direction",
  "tBodyGyroJerk.std...Y"="Standard Deviation of the Angular Velocity Jerking By Time In The Y Direction",
  "tBodyGyroJerk.std...Z"="Standard Deviation of the Angular Velocity Jerking By Time In The Z Direction",
  "tBodyAccMag.mean.."="Mean Linear Body Acceleration Magnitude By Time",
  "tBodyAccMag.std.."="Standard Deviation of the Linear Body Acceleration Magnitude By Time",
  "tGravityAccMag.mean.."="Mean Gravity Acceleration Magnitude By Time",
  "tGravityAccMag.std.."="Standard Deviation of the Gravity Acceleration Magnitude By Time",
  "tBodyAccJerkMag.mean.."="Mean Linear Body Jerking Acceleration Magnitude By Time",
  "tBodyAccJerkMag.std.."="Standard Deviation of the Linear Body Jerking Acceleration Magnitude By Time",
  "tBodyGyroMag.mean.."="Mean Angular Velocity Magnitude By Time",
  "tBodyGyroMag.std.."="Standard Deviation of the Angular Velocity Magnitude By Time",
  "tBodyGyroJerkMag.mean.."="Mean Angular Velocity Jerking Magnitude By Time",
  "tBodyGyroJerkMag.std.."="Standard Deviation of the Angular Velocity Jerking Magnitude By Time",  
  "fBodyAcc.mean...X"="Mean Linear Body Acceleration By Frequency In The X Direction",
  "fBodyAcc.mean...Y"="Mean Linear Body Acceleration By Frequency In The Y Direction",
  "fBodyAcc.mean...Z"="Mean Linear Body Acceleration By Frequency In The Z Direction",
  "fBodyAcc.std...X"="Standard Deviation of the Linear Body Acceleration By Frequency In The X Direction",
  "fBodyAcc.std...Y"="Standard Deviation of the Linear Body Acceleration By Frequency In The Y Direction",
  "fBodyAcc.std...Z"="Standard Deviation of the Linear Body Acceleration By Frequency In The Z Direction",
  "fBodyAcc.meanFreq...X"="Mean Frequency of the Linear Body Acceleration By Frequency In The X Direction",
  "fBodyAcc.meanFreq...Y"="Mean Frequency of the Linear Body Acceleration By Frequency In The Y Direction",
  "fBodyAcc.meanFreq...Z"="Mean Frequency of the Linear Body Acceleration By Frequency In The Z Direction",
  "fBodyAccJerk.mean...X"="Mean Linear Body Jerking Acceleration By Frequency In The X Direction",
  "fBodyAccJerk.mean...Y"="Mean Linear Body Jerking Acceleration By Frequency In The Y Direction",
  "fBodyAccJerk.mean...Z"="Mean Linear Body Jerking Acceleration By Frequency In The Z Direction",
  "fBodyAccJerk.std...X"="Standard Deviation of the Linear Body Jerking Acceleration By Frequency In The X Direction",
  "fBodyAccJerk.std...Y"="Standard Deviation of the Linear Body Jerking Acceleration By Frequency In The Y Direction",
  "fBodyAccJerk.std...Z"="Standard Deviation of the Linear Body Jerking Acceleration By Frequency In The Z Direction",
  "fBodyAccJerk.meanFreq...X"="Mean Frequency of the Linear Body Jerkin Acceleration By Frequency In The X Direction",
  "fBodyAccJerk.meanFreq...Y"="Mean Frequency of the Linear Body Jerkin Acceleration By Frequency In The Y Direction",
  "fBodyAccJerk.meanFreq...Z"="Mean Frequency of the Linear Body Jerkin Acceleration By Frequency In The Z Direction",
  "fBodyGyro.mean...X"="Mean Angular Velocity By Frequency In The X Direction",
  "fBodyGyro.mean...Y"="Mean Angular Velocity By Frequency In The Y Direction",
  "fBodyGyro.mean...Z"="Mean Angular Velocity By Frequency In The Z Direction",
  "fBodyGyro.std...X"="Standard Deviation of the Angular Velocity By Frequency In The X Direction",
  "fBodyGyro.std...Y"="Standard Deviation of the Angular Velocity By Frequency In The Y Direction",
  "fBodyGyro.std...Z"="Standard Deviation of the Angular Velocity By Frequency In The Z Direction",
  "fBodyGyro.meanFreq...X"="Mean Frequency Angular Velocity By Frequency In The X Direction",
  "fBodyGyro.meanFreq...Y"="Mean Frequency Angular Velocity By Frequency In The Y Direction",
  "fBodyGyro.meanFreq...Z"="Mean Frequency Angular Velocity By Frequency In The Z Direction",
  "fBodyAccMag.mean.."="Mean Linear Body Acceleration Magnitude By Frequency",
  "fBodyAccMag.std.."="Standard Deviation of the Linear Body Acceleration Magnitude By Frequency",
  "fBodyAccMag.meanFreq.."="Mean Frequency of the Linear Body Acceleration Magnitude By Frequency",
  "fBodyBodyAccJerkMag.mean.."="Mean Linear Body Jerking Acceleration Magnitude By Frequency",
  "fBodyBodyAccJerkMag.std.."="Standard Deviation of the Linear Body Jerking Acceleration Magnitude By Frequency",
  "fBodyBodyAccJerkMag.meanFreq.."="Mean Frequency of the Linear Body Jerking Acceleration Magnitude By Frequency",
  "fBodyBodyGyroMag.mean.."="Mean Angular Velocity Magnitude By Frequency",
  "fBodyBodyGyroMag.std.."="Standard Deviation of the Angular Velocity Magnitude By Frequency",
  "fBodyBodyGyroMag.meanFreq.."="Mean Frequency of the Angular Velocity Magnitude By Frequency",
  "fBodyBodyGyroJerkMag.mean.."="Mean Angular Jerking Velocity Magnitude By Frequency",
  "fBodyBodyGyroJerkMag.std.."="Standard Deviation of the Angular Jerking Velocity Magnitude By Frequency",
  "fBodyBodyGyroJerkMag.meanFreq.."="Mean Frequency of the Angular Jerking Velocity Magnitude By Frequency",  
  "V2"="Activity"  
    ))
##END STEP 4

##START STEP 5
##AGGREGATE VARIABLES BY SUBJECT AND ACTIVITY
  finalOutput <- aggregate(
              mnStdData[c(
                "Mean Linear Body Acceleration By Time In The X Direction",
                "Mean Linear Body Acceleration By Time In The X Direction",
                "Mean Linear Body Acceleration By Time In The Y Direction",
                "Mean Linear Body Acceleration By Time In The Z Direction",
                "Standard Deviation of the Linear Body Acceleration By Time In The X Direction",
                "Standard Deviation of the Linear Body Acceleration By Time In The Y Direction",
                "Standard Deviation of the Linear Body Acceleration By Time In The Z Direction",
                "Mean Gravity Acceleration By Time In The X Direction",
                "Mean Gravity Acceleration By Time In The Y Direction",
                "Mean Gravity Acceleration By Time In The Z Direction",
                "Standard Deviation of the Gravity Acceleration By Time In The X Direction",
                "Standard Deviation of the Gravity Acceleration By Time In The Y Direction",
                "Standard Deviation of the Gravity Acceleration By Time In The Z Direction",
                "Mean Linear Body Jerking Acceleration By Time In The X Direction",
                "Mean Linear Body Jerking Acceleration By Time In The Y Direction",
                "Mean Linear Body Jerking Acceleration By Time In The Z Direction",
                "Standard Deviation of the Linear Body Jerking Acceleration By Time In The X Direction",
                "Standard Deviation of the Linear Body Jerking Acceleration By Time In The Y Direction",
                "Standard Deviation of the Linear Body Jerking Acceleration By Time In The Z Direction",
                "Mean Angular Velocity By Time In The X Direction",
                "Mean Angular Velocity By Time In The Y Direction",
                "Mean Angular Velocity By Time In The Z Direction",
                "Standard Deviation of the Angular Velocity By Time In The X Direction",
                "Standard Deviation of the Angular Velocity By Time In The Y Direction",
                "Standard Deviation of the Angular Velocity By Time In The Z Direction",
                "Mean Angular Velocity Jerking By Time In The X Direction",
                "Mean Angular Velocity Jerking By Time In The Y Direction",
                "Mean Angular Velocity Jerking By Time In The Z Direction",
                "Standard Deviation of the Angular Velocity Jerking By Time In The X Direction",
                "Standard Deviation of the Angular Velocity Jerking By Time In The Y Direction",
                "Standard Deviation of the Angular Velocity Jerking By Time In The Z Direction",
                "Mean Linear Body Acceleration Magnitude By Time",
                "Standard Deviation of the Linear Body Acceleration Magnitude By Time",
                "Mean Gravity Acceleration Magnitude By Time",
                "Standard Deviation of the Gravity Acceleration Magnitude By Time",
                "Mean Linear Body Jerking Acceleration Magnitude By Time",
                "Standard Deviation of the Linear Body Jerking Acceleration Magnitude By Time",
                "Mean Angular Velocity Magnitude By Time",
                "Standard Deviation of the Angular Velocity Magnitude By Time",
                "Mean Angular Velocity Jerking Magnitude By Time",
                "Standard Deviation of the Angular Velocity Jerking Magnitude By Time",  
                "Mean Linear Body Acceleration By Frequency In The X Direction",
                "Mean Linear Body Acceleration By Frequency In The Y Direction",
                "Mean Linear Body Acceleration By Frequency In The Z Direction",
                "Standard Deviation of the Linear Body Acceleration By Frequency In The X Direction",
                "Standard Deviation of the Linear Body Acceleration By Frequency In The Y Direction",
                "Standard Deviation of the Linear Body Acceleration By Frequency In The Z Direction",
                "Mean Frequency of the Linear Body Acceleration By Frequency In The X Direction",
                "Mean Frequency of the Linear Body Acceleration By Frequency In The Y Direction",
                "Mean Frequency of the Linear Body Acceleration By Frequency In The Z Direction",
                "Mean Linear Body Jerking Acceleration By Frequency In The X Direction",
                "Mean Linear Body Jerking Acceleration By Frequency In The Y Direction",
                "Mean Linear Body Jerking Acceleration By Frequency In The Z Direction",
                "Standard Deviation of the Linear Body Jerking Acceleration By Frequency In The X Direction",
                "Standard Deviation of the Linear Body Jerking Acceleration By Frequency In The Y Direction",
                "Standard Deviation of the Linear Body Jerking Acceleration By Frequency In The Z Direction",
                "Mean Frequency of the Linear Body Jerkin Acceleration By Frequency In The X Direction",
                "Mean Frequency of the Linear Body Jerkin Acceleration By Frequency In The Y Direction",
                "Mean Frequency of the Linear Body Jerkin Acceleration By Frequency In The Z Direction",
                "Mean Angular Velocity By Frequency In The X Direction",
                "Mean Angular Velocity By Frequency In The Y Direction",
                "Mean Angular Velocity By Frequency In The Z Direction",
                "Standard Deviation of the Angular Velocity By Frequency In The X Direction",
                "Standard Deviation of the Angular Velocity By Frequency In The Y Direction",
                "Standard Deviation of the Angular Velocity By Frequency In The Z Direction",
                "Mean Frequency Angular Velocity By Frequency In The X Direction",
                "Mean Frequency Angular Velocity By Frequency In The Y Direction",
                "Mean Frequency Angular Velocity By Frequency In The Z Direction",
                "Mean Linear Body Acceleration Magnitude By Frequency",
                "Standard Deviation of the Linear Body Acceleration Magnitude By Frequency",
                "Mean Frequency of the Linear Body Acceleration Magnitude By Frequency",
                "Mean Linear Body Jerking Acceleration Magnitude By Frequency",
                "Standard Deviation of the Linear Body Jerking Acceleration Magnitude By Frequency",
                "Mean Frequency of the Linear Body Jerking Acceleration Magnitude By Frequency",
                "Mean Angular Velocity Magnitude By Frequency",
                "Standard Deviation of the Angular Velocity Magnitude By Frequency",
                "Mean Frequency of the Angular Velocity Magnitude By Frequency",
                "Mean Angular Jerking Velocity Magnitude By Frequency",
                "Standard Deviation of the Angular Jerking Velocity Magnitude By Frequency",
                "Mean Frequency of the Angular Jerking Velocity Magnitude By Frequency"
                )],
              by=list(Subject = mnStdData$Subject, Activity = mnStdData$Activity),
              mean
  )
##END STEP 5

##WRITE OUTPUT TO UPLOAD FOR GRADING
  write.table(x=finalOutput, file="CourseProject.txt", row.names=FALSE)
}