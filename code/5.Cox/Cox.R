## survival
library(survival)

setwd(" ")
data = read.table("data.txt",sep = "\t", header = T, row.names = 1,check.names = F)

#univariateCoc
cox = coxph(Surv(time, status) ~ riskscore, data)
summary(cox)

cox = coxph(Surv(time, status) ~ age, data)
summary(cox)

cox = coxph(Surv(time, status) ~ as.factor(gender), data)
summary(cox)

cox = coxph(Surv(time, status) ~ as.factor(grade), data)
summary(cox)

cox = coxph(Surv(time, status) ~ as.factor(TMNstage), data)
summary(cox)

#multivariateCox
cox = coxph(Surv(time, status) ~ riskscore+age+as.factor(gender)+as.factor(grade)+as.factor(TMNstage), data)
summary(cox)
