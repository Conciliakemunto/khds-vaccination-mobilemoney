*Load dataset
use "C:\Users\conci\Desktop\KDHS_STATA FILE\KHDS\KHDS\Dataset\KEPR8CDT\KEPR8CFL.DTA",clear

*Preserve original data
preserve

*Select variables
keep hv105 hv104 hv115 hv244 sh135l hv263

*Confirm selected variables
describe

*Rename variables
rename hv105 age
rename hv104 sex
rename hv115 marital_status
rename hv244 land_ownership
rename hv263 mobile_money_use
rename sh135l covid_vaccine

*Inpect data
fre age
fre sex
fre marital_status
fre land_ownership
fre mobile_money_use
fre covid_vaccine

* Recode invalid or 'don't know' values
replace age = . if age > 95
replace age = . if age == 98

*Cleaning sex variable
replace sex = 0 if sex == 2
label define sex_labels 1 "Male" 0 "Female"
label values sex sex_labels


* Create new marital status variable
gen marital_status_clean = .

* Recode according to questionnaire structure
replace marital_status_clean = 1 if marital_status == 1        
replace marital_status_clean = 2 if marital_status == 4         
replace marital_status_clean = 3 if marital_status == 5         
replace marital_status_clean = 4 if marital_status == 3         
replace marital_status_clean = 5 if marital_status == 0         

* Handle missing values
replace marital_status_clean = . if marital_status == .

* Label values
label define marstat 1 "Married or living together" ///
                    2 "Divorced" ///
                    3 "Separated" ///
                    4 "Widowed" ///
                    5 "Never married / never lived together"
label values marital_status_clean marstat
label variable marital_status_clean "Marital Status"

* Label values for clarity
label define landown 0 "No" 1 "Yes"
label values land_ownership landown

* Assign clear labels to values
label define mmoney 0 "No" 1 "Yes"
label values mobile_money_use mmoney

* Clean COVID-19 vaccination variable

*Generate new binary variable
gen covid_vaccinated = .

*Recode: 0 = No (none vaccinated), 1 = Yes (any other valid number of vaccinated)
replace covid_vaccinated = 0 if covid_vaccine == 0
replace covid_vaccinated = 1 if inrange(covid_vaccine, 1, 97)

*Treat 98 ("don't know") as missing
replace covid_vaccinated = . if covid_vaccine == 98

*Define value labels
label define covid_lbl 0 "No" 1 "Yes"

*Assign value labels to variable
label values covid_vaccinated covid_lbl

*Add a variable label
label variable covid_vaccinated "Uptake of COVID-19 Vaccination"




* Assign value labels to the variable
label values covid_vaccinated covid_lbl

* Recode 1 to 12 as Yes (at least one vaccinated)
replace covid_vaccinated = 1 if inrange(covid_vaccine, 1, 12)

* Recode '98' (don't know) as missing
replace covid_vaccinated = . if covid_vaccine == 98

* Assign meaningful value labels
label define covidvacclab 0 "No (none vaccinated)" 1 "Yes (at least one vaccinated)"
label values covid_vaccinated covidvaccla

* Drop rows with missing data in any variable
drop if missing(age) | missing(marital_status_clean) | missing(covid_vaccinated)

*Cleaned data
keep age sex marital_status_clean mobile_money_use land_ownership covid_vaccinated


*Question 1

*Install asdoc if not already installed
cap which asdoc
if _rc {
    ssc install asdoc, replace
}

* Run summary stats and export to Word using asdoc
asdoc summarize age sex marital_status_clean covid_vaccinated, ///
    replace title(Summary Statistics)
	
*Cross Tabulation
asdoc, clear
asdoc tabulate covid_vaccinated sex, row col save(COVID_Vaccination_by_Sex.doc) title(COVID Vaccination by Sex)
asdoc tabulate covid_vaccinated marital_status_clean, row col append save(COVID_Vaccination_by_Marital_Status.doc) title(COVID Vaccination by Marital Status)

*Create age groups
gen age_group = .
replace age_group = 1 if age >=15 & age <=24
replace age_group = 2 if age >=25 & age <=34
replace age_group = 3 if age >=35 & age <=44
replace age_group = 4 if age >=45 & age <=54
replace age_group = 5 if age >=55 & age <=64
replace age_group = 6 if age >=65

label define ageg 1 "15-24" 2 "25-34" 3 "35-44" 4 "45-54" 5 "55-64" 6 "65+"
label values age_group ageg


*Visualizations

graph bar (mean) covid_vaccinated, over(sex) ascategory ///
    title("COVID-19 Vaccination Rate by Sex") ytitle("Proportion Vaccinated")
graph export vacc_by_sex.png, replace

graph bar (mean) covid_vaccinated, over(marital_status_clean) ascategory ///
    title("Vaccination by Marital Status") ytitle("Proportion Vaccinated")
graph export vacc_by_marital.png, replace

graph bar (mean) covid_vaccinated, over(age_group) ascategory ///
    title("Vaccination by Age Group") ytitle("Proportion Vaccinated")
graph export vacc_by_agegroup.png, replace



*Regression 
asdoc logit covid_vaccinated i.age_group i.sex i.marital_status_clean, ///
    replace title(Logistic Regression with Age Groups)

*Diagnostics Tests
*Multicollinearity
reg covid_vaccinated i.age_group i.sex i.marital_status_clean
estat vif


* Hosmer-Lemeshow goodness-of-fit test
asdoc estat gof, group(10) table replace title(Hosmer-Lemeshow Goodness-of-Fit)

* Classification statistics 
asdoc estat class, replace title(Classification Statistics)





*QUESTION 2
*Effect of age, sex, and marital status, ownership of agricultural land on uptake of usage of mobile money
*1. Descriptive statistics
*Summary statistics
summarize age mobile_money_use sex marital_status_clean land_ownership
*Visualisation
graph bar (mean) mobile_money_use, over(marital_status_clean, label(angle(0))) title("Mobile Money Use by Marital Status") ytitle("Proportion Using Mobile Money")

*2. Diagnostic test
*I. Multicollinearity test
reg mobile_money_use age i.sex i.marital_status_clean i.land_ownership
vif

*II. Check Model Specification (Link Test)
logit mobile_money_use age i.sex i.marital_status_clean i.land_ownership
linktest

*III. Goodness of fit test
logit mobile_money_use age i.sex i.marital_status_clean i.land_ownership
estat gof

* ROC Curve
lroc

*3. Logistic regression
logit mobile_money_use age i.sex i.marital_status_clean i.land_ownership
