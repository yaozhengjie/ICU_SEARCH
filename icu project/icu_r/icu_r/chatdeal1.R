#确定需要使用的内核数量
#温度
ifelse(zz %in% c("676","677","223762"),ifelse(zz_value>38 && zz_value<36 , setevents(2),NA),NA)
ifelse(zz %in% c("3494","211","220045"),ifelse(zz_value>38 && zz_value<90 , setevents(3),NA),NA)
ifelse(zz %in% c("4201","778","3784",""),ifelse(zz_value>38 && zz_value<36 , setevents(4),NA),NA)
ifelse(zz %in% c("676","677","223762"),ifelse(zz_value>38 && zz_value<36 , setevents(5),NA),NA)

