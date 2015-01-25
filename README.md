###DRamrattan's Getting and Cleansing Data Course Project

##	Project Summary
		The task assigned was to access and process data from the Human Activity Recognition Using Smartphones Data Set.
		We needed to compile and process multiple files and produce an aggregated dataset for submission.
		I will define the steps taken to accomplish this task below in the Project Implementation Section.
		
##	Necessary Input Files
		The files used for this project were downloaded from the URL:
			"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
		I unzipped the files with built in file structure or the zip file.  The files that I used were:
			/features.txt				Final contains labels for the variables collected in the study.  
										Each row represents one variable name for the columns in the "X_" files described below.
			/activity_labels.txt		File contains numeric codes used for activities and the actual activity names.
										The file will be used as a lookup for activity names from activity codes stored in "Y_" files.
			/test/subject_test.txt		File stores a row for each observation.  The row contains a numeric identifier that represents the subject
										from the related row of the "X_test.txt" file.
			/test/X_test.txt			File contains observations used to test the model.  
			/test/y_test.txt			File contains the predicted activity code for the related observation data from the "X_test.txt" file.
			/train/subject_train.txt	File stores a row for each observation.  The row contains a numeric identifier that represents the subject
										from the related row of the "X_train.txt" file.
			/train/X_train.txt			File contains observations used to train the model.  
			/train/y_train.txt			File contains the activity code for the related observation data from the "X_train.txt" file.
			
##	Project Implementation
		The project was broken into 5 steps:
			1.Merges the training and the test sets to create one data set.
			2.Extracts only the measurements on the mean and standard deviation for each measurement. 
			3.Uses descriptive activity names to name the activities in the data set
			4.Appropriately labels the data set with descriptive variable names. 
			5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
			
		Step 1:
			1.	After some analysis of the files in the zip file, I decided that the files I needed were the ones described in the 
				"Necessary Input Files" section above.  
			2.	I created variables represent all the file paths I needed.
			3.	I loaded features and activity data to individual data frames.
			4.	I loaded the files related to the test set, these included X,Y, and subject data files.
				When loading the X_test data_frame, I used the features data set to set the column names.
			5.	I combined the test data into a data_frame by column binding the X, subject, and activity test files.  
			6.	I loaded the files related to the training set, these included X,Y, and subject data files.
				When loading the X_train data_frame, I used the features data set to set the column names.
			7.	I combined the test and train data frames using row binding to have one complete data set.
		
		Step 3:	(I found doing the steps out of order was simpler)
			1.	I used the activity_labels file to create the descriptive activities.  I used the merge command joined on the Activity Code.
		
		Step 2:	
			1.	I created a vector that contained the features containing "mean" or "std" from the features data frame.
			2.	I added variable names for subject and activity to the vector created in 1.
			3.	I used the vector from 1 and 2 to subset the combined data set.
			
		Step 4:
			1:	I wasn't sure how to rename the labels for the data set to give them more meaning.  So I referred to the features_info.txt file.
				I renamed the labels using the following basic rules:
				a.	If the variable started with a "t" the new variable name contained "By Time" as the "t" indicates the measurement was a time measurement.
				b.	If the variable started with a "f" the new variable name contained "By Frequency" as the "f" indicates the measurement was a frequency
					measurement.
				c.	If the variable contained "Body" the new variable name contained "Body". 
				d.	If the variable contained "Gravity" the new variable name contained "Gravity".
				e.	If the variable contained "Acc" the new variable name contained either "Linear Body Acceleration" or "Gravity Acceleration" 
					depending on c and d.
				f.	If the variable contained "Gyro" the new variable name contained "Angular Velocity"
				g.	If the variable contained "Jerk" the new variable name contained "Jerking"
				h.	If the variable contained "mean" the new variable name contained "Mean"
				i.	If the variable contained "std" the new variable name contained "Standard Deviation"
				j.	If the variable contained ".X" the new variable name contained "In The X Direction"
				k.	If the variable contained ".Y" the new variable name contained "In The Y Direction"
				l.	If the variable contained ".Z" the new variable name contained "In The Z Direction"
					eg. tBodyAcc.mean().X becomes "Mean Linear Body Accelaration By Time In The X Direction"
						fBodyGyro.std().Y becomes "Standard Deviation of the Angular Velocity By Frequency In The Y Direction"
				
##Thank you for taking the time to read this.  Hope it was helpful in understanding my process.