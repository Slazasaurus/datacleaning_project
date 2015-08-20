# datacleaning_project

## Description of Steps

This script cleans the data from the url:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

First, the script reads in the data from all the different files.

The activity ids from y_test.txt and y_train.txt are combined into a single 
dataframe, and translated to the relevant activity names using the information
 from activity_labels.txt.

Using the features labels from features.txt the script sets the column names of
the data frames from X_test.txt and X_train.txt to the names of the features.

As such the column names from the original experiment were reused, but in the final
result of this analysis those column names will represent the mean of the variable
they previously represented. This seems to be an acceptable ambiguity, and is less
cluttered than the convention of prepending mean to every single single variable.

We then subset out the columns that correspond to means or standard devations of
different quantities from the data frames read from X_test.txt and X_train.txt.
To do this I simply read out the indices of these quantities. I was purposefully
liberal in my interpretation of what was a mean. If the word mean occurred anywhere
in the feature label, I kept it. Overcompleteness seems to be an easier issue to
resolve than having to reformat the data again. I made a point of including the
angle variables, as while not all of these are obviously means by the name, they
are in fact means judging by the README.txt and features_info.txt.

The two data frames representing the subsetted X_test.txt and X_train.txt are
then combined row-wise so that the 'train' data appears first in the data frame.
The Subject id vector is then bound as the left most column to the resulting
data frame. Lastly, the activity names are bound to the left most column.

This represents steps 1-4 of the assignment.

In step 5, dplyr was used to group the data frame by the Subjects and Activity.Name
columns, and then apply mean to each grouping. This provides the final result.

## Reading the Data

You can read the data into R using, e.g.:
data <- read.table("clean_data.txt", header = TRUE)
View(data

After downloading the clean data.
