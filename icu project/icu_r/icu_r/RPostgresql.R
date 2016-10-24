## Not run: 
# create a PostgreSQL instance and create one connection.
# m <- dbDriver("PostgreSQL")
# con <- dbConnect(m, user="postgres", host = "serverhost" , port = 5432, password="", dbname="mimic")
# rs <- dbSendQuery(con, "select * from depart")
# df <- fetch(rs, n = 50)
# dbHasCompleted(rs)
# df2 <- fetch(rs, n = -1)
# dbHasCompleted(rs)
#用掉之后必须处理，避免停滞
# dbClearResult(rs)
# dbListTables(con)


m <- dbDriver("PostgreSQL")
con <- dbConnect(m, user="postgres", password="", dbname="mimic")
#获取病人号码
rs <- dbSendQuery(con,"SELECT distinct(subject_id) FROM mimiciii.d_sepsis INNER JOIN mimiciii.diagnoses_icd ON mimiciii.d_sepsis.icd9_code=mimiciii.diagnoses_icd.icd9_code")
#获取病人的检测报告chartevents

rs2 = dbSendQuery(con, "select * from depart")


#单表所有的数据，默认是dataframe
df <- fetch(rs)

rs <- dbSendQuery("SELECT distinct(subject_id) FROM d_sepsis INNER JOIN diagnoses_icd ON d_sepsis.icd9_code=diagnoses_icd.icd9_code")







