# 1

x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")

x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")

features <- read.table('./data/UCI HAR Dataset/features.txt')
labels <- read.table('./data/UCI HAR Dataset/activity_labels.txt')

names(x_train) <- features[,2] 
names(y_train) <-"activity"
names(subject_train) <- "subject"

names(x_test) <- features[,2] 
names(y_test) <- "activity"
names(subject_test) <- "subject"

names(labels) <- c('activity','activityType')

mrg_train <- cbind(y_train, subject_train, x_train)
mrg_test <- cbind(y_test, subject_test, x_test)
setAllInOne <- rbind(mrg_train, mrg_test)

# 2
names <- names(setAllInOne)

mean_and_std <- (grepl("activity" , names) | 
                   grepl("subject" , names) | 
                   grepl("mean.." , names) | 
                   grepl("std.." , names) 
)

setForMeanAndStd <- setAllInOne[ , mean_and_std == TRUE]

# 3
setWithNames <- merge(setForMeanAndStd, labels,
                              by='activity',
                              all.x=TRUE)

# 4
TidySet <- aggregate(. ~subject + activity, setWithNames, mean)
TidySet <- TidySet[order(TidySet$subject, TidySet$activity),]

write.table(TidySet, "TidySet.txt", row.name=FALSE)



