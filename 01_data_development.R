
# Code Section 1: Data Development -------

library(dplyr)        # for data management
library(ggplot2)      # for data visualization
library(sf)           # spatial analysis, for querying data
library(kim)          # for skewness & kurtosis metrics
library(factoextra)
library(psych) # for descriptive stats
library(survey)   # For weighting data
library(jtools)   # For weighted correlations (svycor)
library(Gifi)     # For Non-parametric PCA (princals)

#Set Working Directory to Source File Location

# Assumes your .rdata is in the same location as this File in your repo
load("WVS_Cross-National_Wave_7_Rdata_v6_0.rdata")


# DATA CLEANING & TRANSFORMATION ---------------------------------------

ds <- `WVS_Cross-National_Wave_7_v6_0`

# Select and rename variables for clarity
eda_data <- ds %>%
  select(Q160, Q275, Q287, Q288, Q260, W_WEIGHT) %>%
  rename(
    science_faith = Q160,     # 1-10 (1=Agree science, 10=Agree faith)
    edu_level     = Q275,     # Education
    social_class  = Q287,     # Social class (1=Upper, 5=Lower)
    income_group  = Q288,     # Income (1=Low, 10=High)
    gender        = Q260,      # 1=Male, 2=Female
    weight        = W_WEIGHT
  ) %>%
  
  filter(science_faith > 0, income_group > 0, edu_level > 0, weight > 0) %>%
  mutate(
    gender_label = ifelse(gender == 1, "Male", "Female"),
    # Recode Education into your 3 levels
    edu_cat = case_when(
      edu_level <= 3 ~ "Primary",
      edu_level <= 6 ~ "Secondary",
      TRUE ~ "Post-Secondary"
    ),
    edu_cat = factor(edu_cat, levels = c("Primary", "Secondary", "Post-Secondary"))
  )

# See the overall "shape" of the Science vs. Faith belief
ggplot(eda_data, aes(x = science_faith, weight = weight)) +
  geom_histogram(binwidth = 1, fill = "steelblue", color = "white") +
  theme_minimal() +
  labs(title = "Distribution of Belief (Q160)",
       subtitle = "1 = Science Centric, 10 = Faith Centric",
       x = "Scale", y = "Count of Respondents")

# Save the hand-off file to the current folder
save(eda_data, file = "cleaned_data.RData")
