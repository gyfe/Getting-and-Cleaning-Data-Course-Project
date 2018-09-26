# 1
dataPath <- "UCI HAR Dataset"
x_test <- read.table(file.path(dataPath, "test", "X_test.txt"))
y_test <- read.table(file.path(dataPath, "test", "y_test.txt"))
subject_test <- read.table(file.path(dataPath, "test", "subject_test.txt"))

x_train <- read.table(file.path(dataPath, "train", "X_train.txt"))
y_train <- read.table(file.path(dataPath, "train", "y_train.txt"))
subject_train <- read.table(file.path(dataPath, "train", "subject_train.txt"))

features <- read.table(file.path(dataPath, "features.txt"), as.is = TRUE)
labels <- read.table(file.path(dataPath, "activity_labels.txt"))

names(x_train) <- features[,2] 
names(y_train) <-"activity"
names(subject_train) <- "subject"

names(x_test) <- features[,2] 
names(y_test) <- "activity"
names(subject_test) <- "subject"

names(labels) <- c('activity','activityType')
merge_train <- cbind(y_train, subject_train, x_train)
merge_test <- cbind(y_test, subject_test, x_test)
allinone <- rbind(merge_train, merge_test)

# 2
names <- names(allinone)

mean_and_std <- (grepl("activity" , names) | 
                   grepl("subject" , names) | 
                   grepl("mean.." , names) | 
                   grepl("std.." , names))

mas <- allinone[ , mean_and_std == TRUE]

# 3
Snames <- merge(mas, labels,by='activity',all.x=TRUE)

# 4
TidySet <- aggregate(. ~subject + activity, Snames, mean)
TidySet <- TidySet[order(TidySet$subject, TidySet$activity),]

write.table(TidySet, "Tidyset.txt", row.name=FALSE)



