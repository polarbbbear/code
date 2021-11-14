### Project Name
Predicting of recurrence risk of liver cancer after hepatectomy.

### Summary
We summarize the method of this study, including method codes and input files.

### Environmental dependence
R version 4.0.2

### Random forest
Random forest was used to calculate mean decrease accuracy and mean decrease Gini to measure the importance of each mRNA for liver cancer recurrence.The “randomForest” package in R software was used in this analisis.

### Logistic regression
To construct a risk scoring model for liver cancer recurrence prediction, we developed risk scores using the logistic regression algorithm. The “glmnet” package in R software was used to build the models.

### Univariate and Multivariate Cox Analyses
To further verify the effect of risk score and patient characteristic features on the prognosis of liver cancer, univariate and multivariate Cox analyses were performed for risk score, age, sex, histological grade, and TNM stage. The “survival” package in R software was used to construct the Cox model.

### ROC curve
The area under the ROC curve (AUC) is an accurate indicator in diagnostic tests, which is used to evaluate the quality of the model. The "AUC" package in R software was used to calculete values of the area under the ROC curve.

### Contact
If there is any problem with the codes, please contact us: qxw3399@163.com
