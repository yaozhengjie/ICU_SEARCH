 --1.筛选单纯sirs>2的数据 38719/50311
drop materialized view sirs_2 ;
create materialized view sirs_2 as 
select * from sirs ss
where ss.sirs >= 2 ;
 
 
 --1.删选出符合sirs和感染的病人病例
 ---icustay_id 才是唯一的表格,  19266/29372/61532
 --   19360/29484
drop materialized view sepsis10_all;
create materialized view sepsis10_all as 
select pt.subject_id,pt.hadm_id,pt.icustay_id, pt.sirs from 
 (select subject_id,hadm_id,icustay_id,sirs from sirs ss
where ss.sirs >= 2) pt
inner join 
  patient_diagnosis  --just subject_id
on patient_diagnosis.subject_id = pt.subject_id;
--利用icustay区分病例，subject_id重复

 --先从icustays中筛选出符合年龄的数据，再进行处理，筛选出符合年龄的数据，再进行处理,61532 = icustays
  --46476
 drop view tt;
create view tt as 
select icustays.subject_id,icustays.hadm_id, icustays.icustay_id, icustays.intime - patients.dob bb
,(extract(DAY FROM icustays.intime - patients.dob)
            + extract(HOUR FROM icustays.intime - patients.dob) / 24
            + extract(MINUTE FROM icustays.intime - patients.dob) / 24 / 60
            ) / 365.25
            AS age
from patients
inner join 
  icustays
on patients.subject_id = icustays.subject_id;




--从上表中筛选出成年的病人 ，53332
drop materialized view tt_18;
create materialized view tt_18 as 
select * from tt where age >= 18.0 ;



 --筛选出成年的sepsis1.病例,29251，病人 19150
                         --病例 29362,  病人 19243
drop materialized view sepsis10_18;
 
create materialized view sepsis10_18 as 
select sepsis10_all.subject_id, sepsis10_all.hadm_id , sepsis10_all.icustay_id , tt_18.age 
from  sepsis10_all
inner join
  tt_18
on sepsis10_all.icustay_id = tt_18.icustay_id ;









