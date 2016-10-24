 -- 单纯的sofa>2的数据  35063/46053
  drop materialized view sofa_2
 create materialized view sofa_2 as 
select * from sofa ss
where ss.sofa >= 2 
 --1.筛选出符合sofa和感染的病人病例
 ---icustay_id 才是唯一的表格 27914 /61532  18208/46476
drop materialized view if exists sepsis30_all cascade;
create materialized view sepsis30_all as 
select pt.subject_id,pt.hadm_id,pt.icustay_id, pt.sofa from 
 (select subject_id,hadm_id,icustay_id,sofa from sofa ss
where ss.sofa >= 2) pt
inner join 
  patient_diagnosis  --just subject_id
on patient_diagnosis.subject_id = pt.subject_id;
--利用icustay区分病例，subject_id重复

 --筛选出成年的sepsis3.0病例,27701，病人 18015
 --筛选 病例,27692，病人 18018
drop materialized view sepsis30_18;
 
create materialized view sepsis30_18 as 
select sall.subject_id, sall.hadm_id , sall.icustay_id , tt_18.age 
from  sepsis30_all sall
inner join
  tt_18
on sall.icustay_id = tt_18.icustay_id ;











