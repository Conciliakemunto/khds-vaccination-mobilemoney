# KHDS Dataset Analysis on COVID-19 Vaccination and Mobile Money Usage

## Project Overview  
This Stata project analyzes the Kenya Household Demographic Survey (KHDS) dataset to examine:  
1. The effect of age, sex, and marital status on the uptake of COVID-19 vaccination.  
2. The effect of age, sex, marital status, and agricultural land ownership on the use of mobile money services.  

The analysis includes data cleaning, descriptive statistics, visualizations, logistic regression modeling, and diagnostic tests to validate the models.

## Dataset  
- Source: KHDS (Kenya Household Demographic Survey)    
- Key variables analyzed:  
  - age (hv105)  
  - sex (hv104)  
  - marital_status (hv115)  
  - land_ownership (hv244)  
  - mobile_money_use (hv263)  
  - covid_vaccine (sh135l)  

## Do-file Workflow  
1. Data Preparation and Cleaning  
   - Load the KHDS dataset and preserve the original data.  
   - Select key variables for the analysis.  
   - Rename variables for clarity.  
   - Clean variables (recoding invalid age values, creating binary variables for vaccination status).  
   - Create a cleaned marital status variable with meaningful labels.  
   - Generate age groups for stratified analysis.  
   - Drop observations with missing data on key variables.  

2. Descriptive Statistics and Visualization  
   - Produce summary statistics (means, frequencies).  
   - Create cross-tabulations between vaccination and sex/marital status.  
   - Visualize vaccination uptake by sex, marital status, and age groups.  
   - Visualize mobile money use by marital status (with scope to add by other variables).  

3. Regression Analysis  
   - Logistic regression for:  
     - COVID-19 vaccination uptake ~ age groups, sex, marital status.  
     - Mobile money usage ~ age, sex, marital status, land ownership.  
   - Export regression outputs using the asdoc package.  

4. Diagnostic Tests  
   - Multicollinearity assessed with VIF (using linear regression approximation).  
   - Model specification check using link test.  
   - Goodness-of-fit tests (Hosmer-Lemeshow).  
   - Classification statistics.  
   - ROC curve analysis for model discrimination.  

## Output Files  
- Summary statistics and regression outputs exported as Word documents via asdoc.  
- Graphs saved as PNG files showing key relationships.  
- Tabulations are exported as Word documents for reporting.  

## Notes  
- The do-file uses asdoc for exporting outputs; ensure the package is installed.  
- Missing or invalid responses in survey data are treated as missing and dropped to maintain model integrity.  
- Logistic regression models are fit with categorical variables appropriately labeled.  
- VIF is calculated from linear regression as an approximation for multicollinearity in logistic regression.  
