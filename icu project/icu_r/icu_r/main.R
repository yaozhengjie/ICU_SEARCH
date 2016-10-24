library(Rcpp)
library(compiler)
cppFunction(
  'int fib_cpp_0(int n){
  if(n==1||n==2) return 1;
  return(fib_cpp_0(n-1)+fib_cpp_0(n-2));
  }'
)
patient.data = read.table("F:\\Downloads\\PATIENTS_DATA_TABLE.csv", header = TRUE ,sep = ",")
icustay.data = read.table("F:\\Downloads\\ICUSTAYS.csv", header = TRUE ,sep = ",", nrows = 10)
admissions.data = read.table("F:\\Downloads\\ADMISSIONS.csv", header = TRUE ,sep = ",", nrows = 100)
chartevents.data = read.table("F:\\Downloads\\CHARTEVENTS_DATA_TABLE.csv", header = TRUE ,sep = ",", nrows = 100000)
labevents.data = read.table("F:\\Downloads\\LABEVENTS.csv", header = TRUE ,sep = ",", nrows = 1000000)

sepsis.data = read.table("F:\\Downloads\\sepsis_icu.csv", header = TRUE ,sep = ",")

x= c(1,2,3)
centre =function(type) {
  switch(type,
          "2"=,"3" = 4,
          "5" = 5)
}
x <- iris[which(iris[,5] != "setosa"), c(1,5)]
trials <- 10000
system.time( r <- foreach(icount(trials), .combine=cbind) %dopar% {
  ind <- sample(100, 100, replace=TRUE)
  result1 <- glm(x[ind,2]~x[ind,1], family=binomial(logit))
  coefficients(result1)
})


system.time( r <- foreach(i = 1:trials) %dopar% {
  ind <- sample(100, 100, replace=TRUE)
  result1 <- glm(x[ind,2]~x[ind,1], family=binomial(logit))
  coefficients(result1)
})


system.time( r <- for(i in 1:trials){
  ind <- sample(100, 100, replace=TRUE)
  result1 <- glm(x[ind,2]~x[ind,1], family=binomial(logit))
  coefficients(result1)
})





