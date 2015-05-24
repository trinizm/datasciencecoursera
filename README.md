# datasciencecoursera
A repository for the data scientist's course.

# Tidy Data with Averages from the Human Activity Recognition Using Smartphones Dataset

Additional files: 
  - CodeBook.md
  - Script: run_analysis.R; to be run from the 'data' directory
  - Final dataset: dt_means.txt
  - Please refer to CodeBook.md for additional information re description of dt_means.txt column names

## Steps taken to Transform and Clean the initial datasets

 - Step1 - Merge the training and the test datasets to create one data set

Create datasets:
  - measures: lookup dataset; contains column names, applies to test/train datasets
  - activities: lookup dataset; contains information on activities
  - stest/strain: lookup datasets; contain volunteer identifiers
  - ytest/ytrain: datasets; contain activity identifiers
  - xtest/xtrain: datasets; contain measurement data

  - Add column/variable names from measures dataset to the test/train datasets
  - Create the full test dataset to include: subject_id, activity_id, measures data
  - 2947 rows, 563 columns

  - Create the full train dataset to include: subject_id, activity_id, measures data
  - 7352 rows, 563 columns

  - Merge the train and test datasets to create a full dataset
  - 10299 rows, 563 columns

  - Convert column names to valid column names based on principles that syntactically valid name consists of letters, numbers, dots, underline characters and starts with a letter or the dot not followed by a number
eg: a bracket, hypen, comma are replaced with a dot

 - Step2 - Extracts only the measurements on the mean and standard deviation for each measurement

  - Create a subset that includes subject_id, activity_id, and all 'mean' and 'standard deviation' variables
I included all the columns with names containing 'mean' or 'std', as I believe this project is about transforming and cleaning datasets, and not about debating which measure should be included or not
  - 10299 rows, 88 columns

  - Further clean variable names:
replace three/two dots with one dot; remove the very last dot; replace 'BodyBody' with 'Body'

 - Step3 - Use descriptive activity names to name the activities in the data set

  - Create a new dataset that include column activity_name by merging activities lookup dataset with the full dataset
  - 10299 rows, 89 columns

 - Step4 - Appropriately label the data set with descriptive variable names 

  - Used the following convertion to achieve a more descriptive column naming and used capital letters to separate words:
  - 'f' -> 'Frequency'
  - 't' -> 'Time'
  - 'mean' -> 'Mean'
  - 'std' -> 'StdDev'
  - Did not convert the following: 'Acc', 'Gyro', 'Mag' as I believe the 'full' words are too long and would not contribute to a better description of the variable names
  - Did not remove some dots inside names as they may contribute to the variable name's meaning

 - Step5 - From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject

  - Create a tidy data set with the average of each variable for each activity and each subject;
(activity name, subject id) is a key
  - There is a single row for each key
  - There is a single column for each measurement
  - Save final dataset as a txt file
  - 10299 rows, 88 columns
  - Can be read into R with: read.table("dt_means.txt", header = T)
