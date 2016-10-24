#确定需要使用的内核数量
library(doParallel)
cl <- makeCluster(4)
registerDoParallel(cl)
trials = dim(patient_chartevents)[1]
system.time(for(i in 1:trials){
    #病人编号,subject
    tt = patient_chartevents[[2]][i]
    #找到event中的位置
    location = which(events[[1]] == tt)[1]
    #itemid编号,和value的数值
    zz = patient_chartevents[[3]][i]
    zz_value = patient_chartevents[[4]][i]
    #赋值给最终的表
    switch(
      zz,
      #温度
      "676"=,"677"=,
      "223762" = ifelse(zz_value>38 && zz_value<36 , setevents(2),NA),
      
      #心率
      "3494"=,
      "211"=,
      "220045"= ifelse(zz_value>90 ,setevents(3),NA),
      
      #呼吸频率
      "220210" =,
      "6749" =,
      "618" =,
      "7884"= ifelse(zz_value>20 ,setevents(4),NA),
      #二氧化碳分压,毫米汞柱
      "4201" =,
      "778" =,
      "3784" =,"3835"=,"3836"=,
      "227036"=,"220235" = ifelse(zz_value<32,setevents(4),NA),
      
      #白细胞数目
      "227063"=,"227062"=,"220546"=,"226780"=,
      "4200"=, "1542"=, "861"=, "1127" = ifelse(zz_value>14 && zz_value<4,setevents(5),NA)
    )
  })