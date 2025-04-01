# Load Necessary Libraries
library(tidyverse)
library(lubridate)
library(ggplot2)
library(dplyr)

# Load the Dataset
dailyActivityData <- read.csv("dailyActivity_merged.csv")

# Check Structure of the Dataset
str(dailyActivityData)

# Check the first few rows of the dataset
head(dailyActivityData)

# Convert Data Types
dailyActivityData$Id <- as.character(dailyActivityData$Id)
dailyActivityData$ActivityDate <- as.Date(dailyActivityData$ActivityDate, format="%m/%d/%Y")

# Verify Changes
str(dailyActivityData)

# Create a New Column to Check Sum of Distances
dailyActivityData$sum_distance <- dailyActivityData$VeryActiveDistance + dailyActivityData$ModeratelyActiveDistance + dailyActivityData$LightActiveDistance

# Remove duplicates
dailyActivityData <- dailyActivityData %>% distinct()

# Handle missing values
dailyActivityData <- dailyActivityData %>% drop_na()

# Basic Summary of the Dataset
summary(dailyActivityData)

# Average Daily Activity by User
daily_activity_summary <- dailyActivityData %>% 
  group_by(Id) %>% 
  summarise(AvgSteps = mean(TotalSteps, na.rm = TRUE),
            AvgCalories = mean(Calories, na.rm = TRUE),
            AvgDistance = mean(TotalDistance, na.rm = TRUE))
daily_activity_summary

# Correlation Analysis
cor(dailyActivityData$TotalSteps, dailyActivityData$Calories, use = "complete.obs")

# Visualization: Distribution of Total Steps with mean and median line
ggplot(dailyActivityData, aes(x = TotalSteps)) +
  geom_histogram(binwidth = 1000, fill = "blue", alpha = 0.6) +
  geom_vline(aes(xintercept = mean(TotalSteps, na.rm = TRUE)), color = "red", linetype = "dashed", size = 1) +
  geom_vline(aes(xintercept = median(TotalSteps, na.rm = TRUE)), color = "green", linetype = "dashed", size = 1) +
  labs(title = "Distribution of Total Steps", x = "Total Steps", y = "Frequency") +
  annotate("text", x = mean(dailyActivityData$TotalSteps, na.rm = TRUE) + 2000, y = 50, label = "Mean", color = "red") +
  annotate("text", x = median(dailyActivityData$TotalSteps, na.rm = TRUE) - 2000, y = 50, label = "Median", color = "green")

# Scatter Plot of Total Steps vs Calories with regression line
ggplot(dailyActivityData, aes(x = TotalSteps, y = Calories)) +
  geom_point(alpha = 0.5, color = "red") +
  geom_smooth(method = "lm", color = "blue", se = FALSE) +  # Regression Line
  labs(title = "Total Steps vs Calories Burned", x = "Total Steps", y = "Calories")

# Line Chart of Daily Steps Trend
ggplot(dailyActivityData, aes(x = ActivityDate, y = TotalSteps, group = Id)) +
  geom_line(alpha = 0.2, color = "darkgreen") +
  labs(title = "Daily Steps Trend", x = "Date", y = "Total Steps")

# Boxplot of Total Steps by Day of the Week
dailyActivityData$DayOfWeek <- weekdays(dailyActivityData$ActivityDate)

ggplot(dailyActivityData, aes(x = DayOfWeek, y = TotalSteps)) +
  geom_boxplot(fill = "lightblue") +
  labs(title = "Total Steps by Day of the Week", x = "Day", y = "Total Steps") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Additional: Activity Intensity Analysis
activity_intensity <- dailyActivityData %>% 
  select(Id, VeryActiveMinutes, FairlyActiveMinutes, LightlyActiveMinutes, SedentaryMinutes) %>% 
  pivot_longer(cols = -Id, names_to = "ActivityLevel", values_to = "Minutes")

ggplot(activity_intensity, aes(x = ActivityLevel, y = Minutes, fill = ActivityLevel)) +
  geom_boxplot() +
  labs(title = "Distribution of Activity Intensity", x = "Activity Level", y = "Minutes")
