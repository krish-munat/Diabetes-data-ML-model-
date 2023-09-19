# Load required libraries
library(caret)
library(ggplot2)

# Step 1: Data Extraction
data("C:/Users/windows 11/Downloads/diabetes.csv")
# Display the first few rows of the dataset to get an overview
head(data)

# Step 2: Data Analysis
# Summary statistics of the dataset
summary(data)

# Check for missing values
missing_values <- sum(is.na(data))
cat("Missing Values:", missing_values, "\n")

# Step 3: Data Visualization
# Create a scatter plot to visualize the relationship between Age and Glucose
ggplot(data, aes(x = Age, y = Glucose, color = factor(Outcome))) +
  geom_point() +
  labs(title = "Scatter Plot of Age vs Glucose",
       x = "Age",
       y = "Glucose",
       color = "Outcome") +
  theme_minimal()

# Step 4: Data Preprocessing (if necessary)
# Handle missing values, normalize/standardize features, etc.

# Step 5: Data Splitting
set.seed(123)
trainIndex <- createDataPartition(data$Outcome, p = .8, 
                                  list = FALSE, 
                                  times = 1)
train_data <- data[ trainIndex,]
test_data  <- data[-trainIndex,]

# Display the dimensions of the training and testing datasets
cat("Training Data Dimensions:", dim(train_data), "\n")
cat("Testing Data Dimensions:", dim(test_data), "\n")

# Step 6: Model Selection and Training
model <- glm(Outcome ~ ., data = train_data, family = binomial)

# Step 7: Model Evaluation
predictions <- predict(model, test_data, type = "response")
predictions <- ifelse(predictions > 0.5, 1, 0)

# Display a confusion matrix to evaluate model performance
confusion_matrix <- table(Actual = test_data$Outcome, Predicted = predictions)
print(confusion_matrix)

# Calculate accuracy
accuracy <- sum(diag(confusion_matrix)) / sum(confusion_matrix)
cat("Accuracy:", accuracy, "\n")

# Step 8: Fine-tuning (if necessary)

# Step 9: Model Deployment (if necessary)

 
