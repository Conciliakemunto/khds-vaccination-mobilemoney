# README: KHDS Dataset Analysis on COVID-19 Vaccination and Mobile Money Usage

## Project Overview  
In this project, I analyzed data from the Kenya Household Demographic Survey (KHDS) using Stata. My goal was to explore:  
1. How age, sex, and marital status affect whether people have taken the COVID-19 vaccine.  
2. How age, sex, marital status, and owning agricultural land influence the use of mobile money services.  

The analysis involved cleaning the data, summarizing key statistics, creating visualizations, running logistic regression models, and performing diagnostic tests to make sure the models are solid.

---

## Dataset  
- The data comes from the KHDS (Kenya Household Demographic Survey).  
- In my do-file, I used the dataset located at:  
  `C:\Users\conci\Desktop\KDHS_STATA FILE\KHDS\KHDS\Dataset\KEPR8CDT\KEPR8CFL.DTA`  
- The key variables I focused on are:  
  - Age (`hv105`)  
  - Sex (`hv104`)  
  - Marital status (`hv115`)  
  - Land ownership (`hv244`)  
  - Mobile money use (`hv263`)  
  - COVID-19 vaccination status (`sh135l`)  

---

## Do-file Workflow

**1. Data Preparation and Cleaning**  
- I started by loading the KHDS dataset, making sure to keep the original data intact.  
- Then I selected the important variables needed for my analysis.  
- I renamed variables to make their meaning clearer.  
- I cleaned the data by fixing invalid age entries and creating a binary variable for vaccination status (vaccinated or not).  
- I created a cleaned-up marital status variable with clear labels.  
- I grouped ages into categories to help with the analysis.  
- Finally, I dropped records with missing data on key variables to avoid errors later on.

**2. Descriptive Statistics and Visualization**  
- I generated summary statistics like averages and counts to understand the data better.  
- I made cross-tabulations to see how vaccination relates to sex and marital status.  
- I created visualizations to show vaccination rates by sex, marital status, and age groups.  
- I also visualized mobile money use by marital status, with plans to add more variables in the future.

**3. Regression Analysis**  
- I ran logistic regression models to predict:  
  - COVID-19 vaccination uptake using age groups, sex, and marital status.  
  - Mobile money use using age, sex, marital status, and land ownership.  
- I used the `asdoc` package to export my regression results into Word documents for easy reporting.

**4. Diagnostic Tests**  
- I checked for multicollinearity using VIF, calculated from a linear regression as an approximation.  
- I performed the link test to check model specification.  
- I ran the Hosmer-Lemeshow test to check goodness of fit.  
- I examined classification statistics to see how well the models predict outcomes.  
- I analyzed ROC curves to evaluate how well the models discriminate between outcomes.

---

## Output Files  
- I saved summary statistics and regression outputs as Word documents using `asdoc`.  
- I saved graphs as PNG images to illustrate key findings.  
- Tabulations were also exported as Word documents for easy inclusion in reports.

---

## Notes  
- I treated missing or invalid survey responses as missing data and dropped them to keep the analysis accurate.  
- The logistic regression models use categorical variables with clear labels.  
- Since VIF isn’t directly available for logistic regression, I approximated it using a linear regression model.


