
# Code Section 2: Exploratory Data Analysis with PCA -------

library(dplyr)        # for data management
library(ggplot2)      # for data visualization
library(sf)           # spatial analysis, for querying data
library(kim)          # for skewness & kurtosis metrics
library(factoextra)
library(psych) # for descriptive stats
library(survey)   # For weighting data
library(jtools)   # For weighted correlations (svycor)
library(Gifi)     # For Non-parametric PCA (princals)

#Load data
load("cleaned_data.RData")

# This creates a ranked survey design to get a true Spearman Matrix with weights
eda_ranked <- eda_data %>%
  mutate(across(c(science_faith, income_group, social_class, edu_level), rank))

wvs_design_ranked <- svydesign(ids = ~1, weights = ~weight, data = eda_ranked)

# The correlations with spearman's rho matrix
spearman_matrix <- svycor(~science_faith + income_group + social_class + edu_level, 
                          design = wvs_design_ranked)
print(spearman_matrix)

# NON-PARAMETRIC PCA (Princals) ------
# We use the variables we want to 'group' together
pca_data <- eda_data %>% 
  select(science_faith, income_group, social_class, edu_level, gender)

# Get the sample size (n) for the test
n_size <- nrow(pca_data)

# Bartlett's Test
bartlett_test <- cortest.bartlett(cor(pca_data), n = n_size)
print(bartlett_test)

# KMO Criterion
kmo_result <- KMO(cor(pca_data))
print(kmo_result)

# We use 'princals' (Categorical PCA) 
# It is better than Correspondence Analysis (MCA) because it respects the ORDER 
# of 1-10 scales. MCA treats them as random categories.
cat_pca <- princals(pca_data, ndim = 5, ordinal = TRUE) 

# INTERPRETATION ------

# Eigenvalues & Proportion of Variance
# We create a table to show the 'Explained Variance'
pca_summary <- data.frame(
  Component = 1:5,
  Eigenvalue = cat_pca$evals,
  Proportion_Var = (cat_pca$evals / sum(cat_pca$evals)) * 100
)
print(pca_summary)

# Factor Loadings
print(cat_pca$loadings)

# Scree Plot
plot(1:5, cat_pca$evals, type = "b", pch = 19, col = "blue",
     main = "Scree Plot", xlab = "Principal Component", ylab = "Eigenvalue")

# Loading Plot
plot(cat_pca, main = "Categorical PCA Loading Plot")

#Save Output
save(cat_pca, file = "pca_results.RData")
