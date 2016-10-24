#提取两端是‘’的数据，并且在内部都是数字的数值
sepsis3.0 = dbGetQuery(con,"SELECT * FROM mimiciii.sepsis30_18")
write.table(sepsis3.0,file="sepsis30_18.csv",sep =",",row.names = FALSE)
library(RSelenium)
library(stringr)
library(stringi)
library(RPostgreSQL)
#rawdata = file("E:\\BaiduYunDownload\\mimic-code-master (2)\\mimic-code-master\\sepsis\\angus.sql")
rawdata = readLines("E:\\BaiduYunDownload\\mimic-code-master (2)\\mimic-code-master\\sepsis\\angus.sql")
m <- dbDriver("PostgreSQL")
con <- dbConnect(m, user="postgres", password="huayin303",host="10.73.7.139", dbname="mimic")
d_sepsis   = dbGetQuery(con,"SELECT * FROM mimiciii.d_sepsis")
con <- dbConnect(m, user="postgres", password="huayin303",host="10.73.7.139", dbname="mimicv14")
d_icd_diagnoses = dbGetQuery(con,"SELECT * FROM mimiciii.d_icd_diagnoses")
d_angus = dbGetQuery(con,"SELECT * FROM mimiciii.d_angus")
d_organ = dbGetQuery(con,"SELECT * FROM mimiciii.d_organ")
#转化成csv,不带行号的
write.table(d_organ,file="d_organ.csv",sep =",",row.names = FALSE)
#rawdata = "a 2 '1',101' ,'203', '204', small day!"
#zz = unlist(str_extract_all(rawdata,"'[0-9]+'"))
#531
iinter = intersect(d_sepsis$row_id,d_angus$row_id)
#并集
outerr = union(d_sepsis$row_id,d_angus$row_id)
#301
diffr = setdiff(d_sepsis$row_id,d_angus$row_id)
#604
diffz = setdiff(d_angus$row_id, d_sepsis$row_id)
#重新整理数据集，从整理中获取左联数据
rr = subset(d_sepsis,d_sepsis$row_id %in% diffr)
rrr = subset(d_icd_diagnoses,d_icd_diagnoses$row_id %in% diffr)
#交集数据
ii = subset(d_icd_diagnoses,d_icd_diagnoses$row_id %in% iinter)

zz = subset(d_icd_diagnoses,d_icd_diagnoses$row_id %in% diffz)
write.table(zz,file="angus_fang.csv",sep =",",row.names = FALSE)
write.table(rrr,file="fang_angus.csv",sep =",",row.names = FALSE)
write.table(ii,file="angus&fang.csv",sep =",",row.names = FALSE)

#获取一百个随机sepsis30
sepsis_100 = sample(sepsis3.0$hadm_id,100)
unique(sepsis_100)
sepsis_100 = as.character(sepsis_100)
ww = ""
for(i in 1:length(sepsis_100)){
  if (i == 1)
    ww = sepsis_100[i]
  else
    ww = paste(ww,",",sepsis_100[i])
}

sql = paste0("SELECT * FROM mimiciii.noteevents where category='Discharge summary' and hadm_id in ","(",ww,")")
noteevent_100 = dbGetQuery(con,sql)
write.table(noteevent_100,file="noteevent_100.csv",sep =",",row.names = FALSE)
result = str_extract_all(noteevent_100$text,"PAST MEDICAL HISTORY:|Past Medical History:")
dd = which(str_detect(noteevent_100$text,"PAST MEDICAL HISTORY:|Past Medical History:"))

noteevent_100_1 = data.frame(NULL)
a = rep(NA,106)
for(i in 1:106){
  if (i %in% dd)
    a[i] = noteevent_100$hadm_id[i]
}
a = na.omit(a)
setdiff(noteevent_100$hadm_id,a)

#######################################################################################################################
zz = str_extract_all(noteevent_100$text, "PAST MEDICAL HISTORY:\n[^:]+|Past Medical History:\n[^:]+")
#列表转向量的处理
ff = rep(NA,106)
for(i in 1:106){
  if (length(zz[[i]]) == 0)
    ff[i] = NA
  else
    ff[i] = zz[[i]][1]
}

noteevent_100_2 = data.frame(noteevent_100,ff)
write.csv(noteevent_100_2,file="fenxi106.csv",row.names = FALSE)
#字符处理,判断截取的数据是否过小，过小的就拉伸字数数量
we = nchar(ff)
which(is.na(we))
wee = ifelse(we>50,we,NA)
#截取数据流向,反向处理
pp = stri_reverse(ff)
oo = str_extract(pp,".+\n")
oi = stri_reverse(oo)

oi = factor(oi)
table(oi)
#提取出相对应的项目
oii = data.frame(noteevent_100_2,oi,we,wee)

sss = subset(oii,we < 50)
####################################################################################################################
#anysis all notetext data

notetext = dbGetQuery(con,"SELECT * FROM mimiciii.notetext_sepsis3018")
write.csv(notetext,file="notetext.csv",row.names = FALSE)
##数据库已经做好了处理的工作，筛选》50个字符的数据，并提取他们结束的标题的
notetext_nchar = nchar(notetext$newtxt)

which(is.na(notetext_nchar))
notetext_nchar_we = ifelse(notetext_nchar>200,notetext$newtxt,NA)
#截取数据流向,反向处理
notetext_nchar_pp = stri_reverse(notetext_nchar_we)
notetext_nchar_oo = str_extract(notetext_nchar_pp,".+\n")
notetext_nchar_oi = stri_reverse(notetext_nchar_oo)

notetext_nchar_oi = factor(notetext_nchar_oi)
#善用sort，便于显示
notetext_freq  = sort(table(notetext_nchar_oi))
#提取出相对应的项目
notetext_new = data.frame(notetext,notetext_nchar_oi)
notetext_freq = data.frame(notetext_freq)
write.csv(notetext_freq,file="notetext_freq.csv",row.names = FALSE)

###choose the attributes which not start with -,or num [[:alpha:]]
subtext = str_sub(notetext_freq$notetext_nchar_oi,start = 2 , end = 2)
result_sub = ifelse(str_detect(subtext,"[[:alpha:]]"),1,0 )


notetext[which(result_sub == 1),]
#展示的数据点，就是不以开头的数据
notetext_freq[which(result_sub == 1),]
write.csv(notetext_freq[which(result_sub == 1),],file="notetext111.csv",row.names = FALSE)
##################################### restart to  solve###########################################################
##choose the data 
write.csv(notetext,file="notetext.csv",row.names = FALSE)

###随机选择200例数据，进行处理
temp = na.omit(notetext)
temp = temp
zz = sample(c(1:dim(temp)[1]),200)
ttemp = temp[zz,]
write.csv(ttemp,file="sample200.csv",row.names = FALSE)


#create
notetext = dbGetQuery(con,"SELECT * FROM mimiciii.notetext")
write.csv(ttemp,file="notetext_category_discharge_summary_PMH.csv",row.names = FALSE)



