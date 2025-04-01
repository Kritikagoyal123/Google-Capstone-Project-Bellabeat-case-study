# 📊 Bellabeat Case Study: Data-Driven Insights for Smart Wellness Strategy 🚀

## 🔍 About This Project
This case study analyzes Fitbit fitness tracker data to uncover user behavior patterns related to activity levels, sleep habits, heart rate, and calorie burn. The goal is to provide data-driven recommendations that will enhance Bellabeat’s marketing and product strategy.

---

## 🏆 Project Summary

### 📌 **Objective:**
Bellabeat, a high-tech company specializing in health-focused smart devices, aims to analyze user activity data to improve its marketing and product strategies. This project delves into trends related to steps, calories, heart rate, sleep, and activity levels, providing actionable insights to guide the company’s approach to customer engagement.

### 🔑 **Key Insights**
- **Most users take between 0 and 20,000 steps**, with a **right-skewed distribution**, suggesting **moderate activity levels** are more common, while higher activity levels are less frequent. 👟📊
- **Positive correlation** between total steps and calories burned, indicating that **higher activity levels lead to increased calorie expenditure.** 🏃‍♂️🔥
- **Daily step counts fluctuate significantly**, with occasional high-activity spikes, indicating inconsistent user activity levels. 📈🚀
- **Step activity remains fairly consistent** across the week, with **Saturday showing slightly higher median steps** and occasional outliers. 🚶‍♂️📊

---

## 📌 Steps in the Analysis

### **🔹 Step 1: Ask**
#### **Business Task:**
Identify potential opportunities for growth and provide recommendations for Bellabeat's marketing strategy improvement based on trends in smart device usage.

#### **Key Stakeholders:**
- **Urška Sršen** (Bellabeat's Co-founder & Chief Creative Officer)
- **Sando Mur** (Mathematician & Bellabeat Co-founder)

#### **Key Questions:**
1. What are some trends in smart device usage?
2. How could these trends apply to Bellabeat customers?
3. How could these trends help influence Bellabeat marketing strategy?

### **🔹 Step 2: Prepare**
#### **Data Source:**
The dataset used in this analysis is from Kaggle: [FitBit Fitness Tracker Data](https://www.kaggle.com/datasets/arashnic/fitbit), provided under CC0: Public Domain.

#### **Data Quality Assessment (ROCCC Approach):**
- **Reliability:** Low (Only 30 Fitbit users participated)
- **Originality:** Low (Collected via Amazon Mechanical Turk)
- **Comprehensiveness:** Medium (Includes data on steps, heart rate, calories, sleep)
- **Currentness:** Low (Data is from March 2016 - May 2016)
- **Cited:** Low (Third-party data with no clear documentation)

### **🔹 Step 3: Process**
Data was cleaned, formatted, and transformed using **R programming**.

#### **Loading Required Packages:**
```r
library(tidyverse)
library(lubridate)
library(ggplot2)
library(dplyr)
```

#### **Importing and Preparing the Dataset:**
```r
# Read the data
 dailyActivityData <- read.csv("dailyActivity_merged.csv")

# Convert Data Types
dailyActivityData$Id <- as.character(dailyActivityData$Id)
dailyActivityData$ActivityDate <- as.Date(dailyActivityData$ActivityDate, format="%m/%d/%Y")

# Remove Duplicates and Handle Missing Values
dailyActivityData <- dailyActivityData %>% distinct() %>% drop_na()

# Create a New Column for Total Distance
dailyActivityData$sum_distance <- dailyActivityData$VeryActiveDistance + dailyActivityData$ModeratelyActiveDistance + dailyActivityData$LightActiveDistance
```

### **🔹 Step 4: Analyze**
#### **Summary Statistics & Correlation Analysis:**
```r
summary(dailyActivityData)
cor(dailyActivityData$TotalSteps, dailyActivityData$Calories, use = "complete.obs")
```

#### **Visualizations:**
##### **1️⃣ Distribution of Total Steps**
```r
ggplot(dailyActivityData, aes(x = TotalSteps)) +
  geom_histogram(binwidth = 1000, fill = "blue", alpha = 0.6) +
  geom_vline(aes(xintercept = mean(TotalSteps, na.rm = TRUE)), color = "red", linetype = "dashed", size = 1) +
  geom_vline(aes(xintercept = median(TotalSteps, na.rm = TRUE)), color = "green", linetype = "dashed", size = 1) +
  labs(title = "Distribution of Total Steps", x = "Total Steps", y = "Frequency")
```

##### **2️⃣ Scatter Plot of Total Steps vs Calories Burned**
```r
ggplot(dailyActivityData, aes(x = TotalSteps, y = Calories)) +
  geom_point(alpha = 0.5, color = "red") +
  geom_smooth(method = "lm", color = "blue", se = FALSE) +
  labs(title = "Total Steps vs Calories Burned", x = "Total Steps", y = "Calories")
```

##### **3️⃣ Boxplot of Total Steps by Day of the Week**
```r
dailyActivityData$DayOfWeek <- weekdays(dailyActivityData$ActivityDate)

ggplot(dailyActivityData, aes(x = DayOfWeek, y = TotalSteps)) +
  geom_boxplot(fill = "lightblue") +
  labs(title = "Total Steps by Day of the Week", x = "Day", y = "Total Steps") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
```

##### **4️⃣ Activity Intensity Analysis**
```r
activity_intensity <- dailyActivityData %>%
  select(Id, VeryActiveMinutes, FairlyActiveMinutes, LightlyActiveMinutes, SedentaryMinutes) %>%
  pivot_longer(cols = -Id, names_to = "ActivityLevel", values_to = "Minutes")

ggplot(activity_intensity, aes(x = ActivityLevel, y = Minutes, fill = ActivityLevel)) +
  geom_boxplot() +
  labs(title = "Distribution of Activity Intensity", x = "Activity Level", y = "Minutes")
```

### **🔹 Step 5: Share**
📊 Visualizations generated:
![Rplot01](https://github.com/user-attachments/assets/74b2b3a0-8a8a-4e36-b2ea-b537203a50bc)
![Rplot02](https://github.com/user-attachments/assets/4b6ff9f1-228f-4d17-98d3-858caabd43ef)
![Rplot03](https://github.com/user-attachments/assets/12f93146-84fc-4cf0-add3-60d4d6bf56bf)
![Rplot04](https://github.com/user-attachments/assets/59a0a5b0-f1ab-4899-9339-908f8573a128)

### **🔹 Step 6: Act**
This analysis provides insights into Bellabeat's customer activity trends to enhance its marketing and product strategy.


