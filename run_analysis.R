run_analysis <- function() {
  ## Name: run_analysis.R
  #
  ## Step0 - Download data
  ## Step1 - Merge the training and the test datasets to create one data set.
  ## Step2 - Extracts only the measurements on the mean and standard deviation for each measurement. 
  ## Step3 - Use descriptive activity names to name the activities in the data set
  ## Step4 - Appropriately label the data set with descriptive variable names. 
  ## Step5 - From the data set in step 4, create a second, independent tidy data set 
  #          with the average of each variable for each activity and each subject.
  #
  ###############################################################
  #
  library(plyr)
  library(dplyr)
    
  ## Step0
  measures <- read.table("./features.txt", col.names=c("measure_id","measure_name"))
  activities <- read.table("./activity_labels.txt", col.names=c("activity_id","activity_name"), stringsAsFactors=FALSE)
  stest <- read.table("./test/subject_test.txt", col.names=c("subject_id"), stringsAsFactors=FALSE)
  strain <- read.table("./train/subject_train.txt", col.names=c("subject_id"), stringsAsFactors=FALSE)
  ytest <- read.table("./test/y_test.txt", col.names=c("activity_id"), stringsAsFactors=FALSE)
  ytrain <- read.table("./train/y_train.txt", col.names=c("activity_id"), stringsAsFactors=FALSE)
  xtest <- read.table("./test/X_test.txt", stringsAsFactors=FALSE)
  xtrain <- read.table("./train/X_train.txt", stringsAsFactors=FALSE)
  
  ## Step1
  ## Add column names from measures dataset to the test and train datasets
  names(xtest) <- measures[,2]
  names(xtrain) <- measures[,2]
  
  ## Merge test datasets
  data_test <- cbind(stest, ytest, xtest)
  
  ## Merge train datasets
  data_train <- cbind(strain, ytrain, xtrain)
  
  ## Merge train and test datasets to create a full dataset
  data_all <- rbind(data_test, data_train)
  
  ## Convert column names to valid column names
  valid<- make.names(names=names(data_all), unique=T, allow_=T)
  names(data_all)<- valid
  
  ## Step2
  data_sub1<-select(data_all, subject_id, activity_id, contains("mean"), contains("std"))
  
  # clean column names
  colnames(data_sub1)<- sub("...", ".", colnames(data_sub1), fixed=TRUE)
  colnames(data_sub1)<- sub("..", ".", colnames(data_sub1), fixed=TRUE)
  colnames(data_sub1)<- sub("\\.$", "", colnames(data_sub1))
  colnames(data_sub1)<- sub("BodyBody", "Body", colnames(data_sub1), fixed=TRUE)
  
  ## Step3
  data_sub2 <- merge(data_sub1, activities, "activity_id")
  
  ## Step4
  colnames(data_sub2)<- sub("tBody", "TimeBody", colnames(data_sub2), fixed=TRUE)
  colnames(data_sub2)<- sub("tGravity", "TimeGravity", colnames(data_sub2), fixed=TRUE)
  colnames(data_sub2)<- sub("Freq", "Frequency", colnames(data_sub2), fixed=TRUE)
  colnames(data_sub2)<- sub("fBody", "FrequencyBody", colnames(data_sub2), fixed=TRUE)
  colnames(data_sub2)<- sub("gravity", "Gravity", colnames(data_sub2), fixed=TRUE)
  colnames(data_sub2)<- sub("mean", "Mean", colnames(data_sub2), fixed=TRUE)
  colnames(data_sub2)<- sub("std", "StdDev", colnames(data_sub2), fixed=TRUE)
  colnames(data_sub2)<- sub("angle", "Angle", colnames(data_sub2), fixed=TRUE)
  
  ## Step5
  # calculate means
  # add 'Mean' to all column names except 'activity_name', 'subject_id'
  dt <- data_sub2[, -c(1)]
  dt_means <- ddply(dt, .(activity_name, subject_id), function(x) { colMeans(x[,-c(1,88)]) })
  names(dt_means)[-c(1,2)] <- paste0("Mean", names(dt_means)[-c(1,2)])
  
  # save final dataset as a txt file
  write.table(dt_means, file="dt_means.txt", row.name=FALSE)
  
  # return data
  #dt_means
}
