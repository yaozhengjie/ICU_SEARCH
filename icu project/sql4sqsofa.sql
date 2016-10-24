 --select count(distinct(subject_id)) from sepsis30qq_18
--快速sofa检测，27311/35638
drop materialized view qsofa_2;
create materialized view qsofa_2 as 
select * from qsofa ss
where ss.qsofa >= 2 ;


 --1.筛选出符合sofa和感染的病人病例
 ---icustay_id 才是唯一的表格 16157/23168
  --                          16244/23258
drop materialized view if exists sepsisqq30_all cascade;
create materialized view sepsisqq30_all as 
select pt.subject_id,pt.hadm_id,pt.icustay_id, pt.qsofa from 
qsofa_2 pt
inner join 
  patient_diagnosis  --just subject_id
on patient_diagnosis.subject_id = pt.subject_id;
--利用快速sofa 16150/23159
--		16237/23249
create materialized view sepsis30qq_18 as 
select sall.subject_id, sall.hadm_id , sall.icustay_id , tt_18.age 
from  sepsisqq30_all sall
inner join
  tt_18
on sall.icustay_id = tt_18.icustay_id ;