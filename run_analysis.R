run_analysis <- function(dir) {
  orig <- getwd()
  setwd(dir)
  features <- read.table("features.txt")$V2
  test <- read.table("test/X_test.txt", col.names=features)
  train <- read.table("train/X_train.txt", col.names=features)
  activity_names <- read.table("activity_labels.txt")
  activity_nums_train <- read.table("train/y_train.txt")
  activity_nums_test <- read.table("test/y_test.txt")
  test_subjects <- read.table("test/subject_test.txt")
  train_subjects <- read.table("train/subject_train.txt")
  setwd(orig)
  subjects <- rbind(train_subjects, test_subjects)
  names(subjects) <- "Subjects"
  # Assumes the train stuff is 'first'
  actual_names <- c(as.character(activity_names[activity_nums_train[,1], 2]),
                      as.character(activity_names[activity_nums_test[,1], 2])
                      )
  # At which point all the data is in front of us
  # We subset out just the means and standard deviations
  means_n_stds <- c(1,2,3,4,5,6,41,42,43,44,45,46,81,
                   82,83,84,85,86,121,122,123,124,125,126,
                   161,162,163,164,165,166,201,202,214,215,
                   227,228,240,241,253,254,266,267,268,269,
                   270,271,294,295,296,345,346,347,348,349,
                   350,424,425,426,427,428,429,452,453,454,
                   503,504,516,517,529,530,542,543,555,556,
                   557,558,559,560,561)
  selected_train <- train[,means_n_stds]
  selected_test <- test[,means_n_stds]
  # We snip the data sets together
  result_A <- rbind(selected_train, selected_test)
  result_A <- cbind(Subjects=subjects, result_A)
  result_A <- cbind(Activity.Names=actual_names, result_A)
  # Now we take the data, group it by Subject and Activity
  # and apply the mean function to each column by group
  groups <- lapply(names(result_A)[1:2], as.symbol)
  result <- result_A %>% group_by_(.dots=groups) %>% summarise_each(funs(mean))
  # We return the result for debugging if desired.
  write.table(result, file="clean_data.txt", row.name =FALSE)
  result
}