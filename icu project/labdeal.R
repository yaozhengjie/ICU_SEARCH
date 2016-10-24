#处理lab数据
trials = dim(patient_labevents)[1]
for(i in 1:trials){
  #病人编号,subject
  tt = patient_labevents[[2]][i]
  #找到event中的位置
  location = which(events[[1]] == tt)
  #itemid编号,和value的数值
  zz = patient_labevents[[3]][i]
  zz_value = patient_labevents[[4]][i]
  #赋值给最终的表
  switch(
    zz,
    #二氧化碳分压,毫米汞柱
    "50818"=,"50830" = ifelse(zz_value<32,setevents(4),NA),
    
    #白细胞数目
    "51300"=,"51516"=,
    #幼稚细胞数    
    "51148"= ifelse(zz_value>14 && zz_value<4,setevents(5),NA)
  )
}