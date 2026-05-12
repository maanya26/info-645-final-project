<img width="700" height="350" alt="34389091-9DD2-4908-88C8-73BC0A4F7718_4_5005_c" src="https://github.com/user-attachments/assets/cf383f95-7f3b-4368-8267-ff58d385e580" />

# The Socioeconomics of Science and Faith: Identifying Demographic and Cognitive Predictors of Belief Centricity

**Team:** [Maanya Agarwal](www.linkedin.com/in/maanya-agarwal)  
**Affiliation:** [Pratt Institute, School of Information](https://www.pratt.edu/information)  
**Course:** INFO 640: Data Analysis  
**Instructor:** [John Lauermann](https://github.com/jlauermann)

This repository contains code and data related to a global analysis of the "Science-Faith" worldview axis. Using a longitudinal and cross-national approach, this project identifies how socioeconomic status (SES) and demographic identity structure personal belief systems. This research explores the "narrowing effect" of education on belief variance and the role of social safety nets in trust in science.

## Analysis Products

The project delivers three primary analytical components:
* **The Worldview Axis (Categorical PCA)**: A dimensionality reduction analysis that identifies how Education, Income, and Social Class load onto a single cognitive dimension.
* **Frequentist Baseline (Ordinal Regression)**: A proportional odds logistic regression (`polr`) providing a frequentist assessment of predictor significance for ranked 10-point scales.
* **Bayesian Posterior Distributions**: A cumulative logit model (`brms`) that estimates the full probability distribution of effects, allowing for a nuanced look at uncertainty and variance across social strata.

## Data Source
Data is drawn from the **World Values Survey Wave 7 (2017-2022)**. 
* **Source:** Haerpfer, C., Inglehart, R., Moreno, A., Welzel, C., Kizilova, K., Diez-Medrano J., M. Lagos, P. Norris, E. Ponarin & B. Puranen (eds.). 2022. World Values Survey: Round Seven – Country-Pooled Datafile Version 6.0. Madrid, Spain & Vienna, Austria: JD Systems Institute & WVSA Secretariat. doi:10.14281/18241.24
* **Access:** The raw dataset is provided in the `/data` folder. For original source documentation, visit the [WVS Website](https://www.worldvaluessurvey.org/WVSDocumentationWV7.jsp).

## How to use

The replication code is organized into a modular pipeline across three segments. The statistical workflow runs on **R**, primarily using `dplyr` for data management, `Gifi` for PCA, and `brms` for Bayesian modeling.

### Replication Instructions
1. **Download** all files into a single local folder.
2. Open RStudio and open the first script: `01_data_development.R`.
3. Go to **Session > Set Working Directory > To Source File Location**.
4. Run the scripts in numerical order:
   - `01_data_development.R`: Cleans raw WVS data and develops the primary data frame for selected varaibles.
   - `02_eda.R`: Conducts the exploratory analysis, including Spearman correlation and Non-parametric PCA to find the 'Worldview Axis'.
   - `03_modeling.R`: Runs Bayesian and Frequentist Ordinal regressions, producing the final posterior distribution plots and regression tables.

Each script defines its required packages and utilizes project-oriented workflows with relative file paths to ensure automated data hand-offs.

## Findings & Interpretation
* **The Status Driver:** Self-perceived social class is the strongest predictor; lower-class identification correlates with higher faith-centricity.
* **The Narrowing Effect:** As education levels increase, beliefs cluster more tightly toward "Science," showing a reduction in variance compared to lower education tiers.
* **Gender Disparity:** Men are significantly more likely to prioritize scientific frameworks, while women show a higher probability of faith-centricity.

## Derivative Products
* [Detailed Project Case Study]()

## How to Cite
Agarwal, M. (2026). *The Socioeconomics of Science and Faith: Identifying Demographic and Cognitive Predictors of Belief Centricity*. INFO 640 Data Analysis, Pratt Institute.

## License

<a rel="license" href="http://creativecommons.org/licenses/by-nc/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-nc/4.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-nc/4.0/">Creative Commons Attribution-NonCommercial 4.0 International License</a>.
