<img width="700" height="350" alt="34389091-9DD2-4908-88C8-73BC0A4F7718_4_5005_c" src="https://github.com/user-attachments/assets/cf383f95-7f3b-4368-8267-ff58d385e580" />

# The Socioeconomic war between Science and Faith: 
Data Analysis Final Project
**Author:** Maanya Agarwal  
**Course:** INFO 640 Data Analysis  

## Project Overview
This repository contains a full data science pipeline investigating how social class, education, and gender predict worldviews on a 10-point scale (Science vs. Faith).

## How to Reproduce This Analysis
This project is built as an automated pipeline. Follow these steps:

1. **Download** all files into a single local folder.
2. Open RStudio and open the first script: `01_data_development.R`.
3. Go to **Session > Set Working Directory > To Source File Location**.
4. Run the scripts in numerical order:
   - `01_data_development.R`: Cleans raw WVS data.
   - `02_eda_pca.R`: Conducts Non-parametric PCA to find the 'Worldview Axis'.
   - `03_modeling.R`: Runs Bayesian and Frequentist Ordinal regressions.

## Model Logic & Best Practices
- **Literate Programming:** Each script is annotated to explain the "why" behind statistical choices (e.g., using Princals for ordinal data).
- **Automated Pipeline:** Each script saves intermediate `.RData` files to ensure a seamless "hand-off" between stages.
- **Robustness:** I use both Frequentist and Bayesian methods to triangulate findings.
