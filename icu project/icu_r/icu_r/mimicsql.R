library(RPostgreSQL)

m <- dbDriver("PostgreSQL")
con <- dbConnect(m, user="postgres", password="", dbname="mimic")

#获取病人号码,处理病例
patient_diagnosis   = dbGetQuery(con,"SELECT * FROM mimiciii.patient_diagnosis")
patient_chartevents = dbGetQuery(con,"SELECT row_id,subject_id,itemid,valuenum FROM mimiciii.patient_chartevents2")
patient_labevents   = dbGetQuery(con,"SELECT row_id,subject_id,itemid,valuenum FROM mimiciii.patient_labevents")

patients            = dbGetQuery(con,"SELECT row_id,subject_id,expire_flag FROM mimiciii.patients")
#创建表格，四项数据，投篮方式处理
h = dim(patient_diagnosis)[1]
l = 4
events = data.frame(matrix(rep(0,h*l),nrow = h))
events = data.frame(patient_diagnosis[[1]],events)
#开始投篮处理，在处理中把六项变成四项
#设计一个函数，放置数据到主表
setevents = function(index){
  events[[index]][location] <<- 1
}
patient_chartevents[[3]] = as.character(patient_chartevents[[3]])

source("chartdeal1.R")
source("labdeal.R")




#将数据重新分配，去掉里面的空数据
head(events)



#统计4个指标中是否有超过两项符合,则确定为病人
##检查一下数据中是否有数据缺失，这个会很头疼
temp = data.frame(apply(events[-1],1,sum))
temp = ifelse(temp>=2,1,0)
combinetable = data.frame(events[[1]],temp)
rm(rs1, rs2 ,rs)
gc()


#保存为sepsis人数
sepsistable = subset(combinetable, combinetable[[2]] == 1)


#统计死亡率，从patient表中获取,检测出是确证脓毒症中死亡的人数/脓毒症总人数
#数据的数据
#sepsis_patient_table = patients[which(patients[[2]] %in% intersect(sepsistable[[1]], patients[[2]])),]
sepsis_patient_table = patients[which(patients[[2]] %in% sepsistable[[1]]),]
death_sepsis = sum(sepsis_patient_table[[3]])


death_rate = death_sepsis/dim(sepsis_patient_table)[1]




