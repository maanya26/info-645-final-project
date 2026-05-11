
# Code Section 3: Ordinal & Bayesian Modeling: Science vs Faith-------

# Load the data created by Script 01
load("cleaned_data.RData")

# load libraries
library(dplyr)        # for data management
library(ggplot2)      # for data visualization
library(psych) # for descriptive stats
library(survey)   # For weighting data
library(jtools)   # For weighted correlations (svycor)
library(MASS)       # For frequentist ordinal regression
library(brms)       # For Bayesian ordinal regression (Professor's recommendation)


# Data Preparation
# We must ensure the DV is an ordered factor
model_data <- eda_data %>%
  mutate(science_faith_f = as.ordered(science_faith),
         gender = as.factor(gender_label)) %>%
  sample_n(2000) # Sample size for computational efficiency

# 2. Frequentist Ordinal Logistic Regression
# A proportional odds model
ordinal_fit <- polr(science_faith_f ~ edu_level + gender + income_group + social_class, 
                    data = model_data, Hess = TRUE)
summary(ordinal_fit)

# 3. Bayesian Ordinal Regression
# family = cumulative("logit") is the ordinal version
bayes_ordinal <- brm(
  formula = science_faith_f ~ edu_level + gender + income_group + social_class,
  data = model_data,
  family = cumulative("logit"),
  chains = 2, iter = 1000, 
  seed = 123
)

# 4. View results
print(summary(bayes_ordinal))

# 5. Visualization
# using mcmc_plot 
mcmc_plot(bayes_ordinal, 
          variable = c("b_edu_level", "b_genderMale", "b_income_group", "b_social_class"), 
          type = "areas", 
          prob = 0.95) +
  theme_minimal() +
  geom_vline(xintercept = 0, color = "red", linetype = "dashed") +
  labs(
    title = "Bayesian Ordinal Posterior Distributions",
    subtitle = "Predicting Faith-Centricity (Positive = Leans Faith, Negative = Leans Science)",
    x = "Log-Odds Estimate",
    y = "Predictor"
  )

library(modelsummary)
#define Models in list
models <- list(
  "Frequentist (Ordinal)" = ordinal_fit,
  "Bayesian (Ordinal)" = bayes_ordinal
)

# Generate the table
## 1. Frequentist Table
modelsummary(ordinal_fit, 
             statistic = "std.error", 
             stars = TRUE, 
             coef_map = c(
               "edu_level" = "Education Level",
               "genderMale" = "Gender (Male)",
               "income_group" = "Income Group",
               "social_class" = "Social Class"
             ),
             title = "Table 1: Frequentist Ordinal Regression Results")

## 2. Bayesian
modelsummary(bayes_ordinal, 
             statistic = "conf.int", 
             coef_map = c(
               "b_edu_level" = "Education Level",
               "b_genderMale" = "Gender (Male)",
               "b_income_group" = "Income Group",
               "b_social_class" = "Social Class"
             ),
             title = "Table 2: Bayesian Ordinal Regression Results")
