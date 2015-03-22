
# Read training data
trainData = read.table("../UCI/train/X_train.txt", sep="")

# Read testing data
testData = read.table("../UCI/test/X_test.txt", sep="")

# Merge training and testing data
allData = rbind(trainData, testData)

# Get descriptive names for each column in the merged data set
columnNames = read.table("../UCI/features.txt")

# Change the column names of allData to its descriptive counterparts
names(allData) = columnNames[, 2]

# extract means for each activity
featureMeans = apply(allData, 2, mean)

# Extract standard deviations for each activity
featureSDs = apply(allData, 2, sd)

# combine feature means and feature standard deviation
featureSummary = cbind(featureMeans, featureSDs)

# Read subject data
trainSubject = read.table("../UCI/train/subject_train.txt")
testSubject = read.table("../UCI/test/subject_test.txt")
subject = rbind(trainSubject, testSubject)

# Append subject infor to the merged data set
allData = cbind(allData, subject)
names(allData)[562] = "subject"


s1 = subset(allData[, 1:561], subject==1)
s1Summary = apply(s1, 2, mean)

tidyData = as.data.frame(s1Summary)

for(i in 2:30)
{
  s = subset(allData[, 1:561], subject=i)
  sSummary = apply(s, 2, mean)
  tidyData = cbind(tidyData, sSummary)  
}
