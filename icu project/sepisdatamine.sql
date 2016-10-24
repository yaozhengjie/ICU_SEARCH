/*
从被感染人群中，提取出符合脓毒症感染数据表中的感染者的编号
*/

select distinct(subject_id) from diagnoses_icd order by subject_id as sepsis_id;


DROP TABLE IF EXISTS SEPSIS_ICD CASCADE;
CREATE TABLE D_SEPSIS
   (
    ROW_ID INT NOT NULL,
	ICD9_CODE VARCHAR(10) NOT NULL,
	CONSTRAINT d_icd_diag_code_unique UNIQUE (ICD9_CODE),
   ) ;
/*
复制数据
*/
\copy D_SEPSIS from 'D_SEPSIS.csv' delimiter ',' csv header NULL ''

select row_id,icd9_code from diagnoses_icd 
intersect 
select row_id,icd9_code from d_sepsis where icd9_code>'200';

SELECT * FROM d_sepsis
INNER JOIN diagnoses_icd
ON  d_sepsis.icd9_code=diagnoses_icd.icd9_code; 
/*
创建保存感染人群的数据库
*/
create table patient_diagnosis(
subject_id int not null,
constraint patient_diagnosis_pk primary key (subject_id)
);

/*
取交集数据，受感染的病人，并保存到感染人群数据表中
*/


/*
SELECT distinct(subject_id) FROM d_sepsis
INNER JOIN diagnoses_icd
ON d_sepsis.icd9_code=diagnoses_icd.icd9_code; 
*/
SELECT distinct(subject_id) into patient_diagnosis 
FROM d_sepsis INNER JOIN diagnoses_icd
ON d_sepsis.icd9_code=diagnoses_icd.icd9_code; 





select subject_id 
from d_sepsis INNER JOIN diagnoses_icd
ON d_sepsis.icd9_code=diagnoses_icd.icd9_code
group by subject_id;

/*
从chartevents中获取交集数据，处理文件
*/
alter table patient_diagnosis2 ALTER COLUMN subject_id type int;
alter table patient_diagnosis2 alter column subject_id set  not null;

SELECT s.row_id, s.subject_id, s.hadm_id, s.icustay_id, s.itemid, s.charttime, s.storetime, s.value, s.valuenum  into patient_chartevents2 
FROM chartevents as s
where chartevents.subject_id = any (SELECT subject_id from patient_sepsis);

/*
删选出将数据中label字段中，为 ，并返回item
*/

select * from d_items where label like '%CO2%';

/*
比较多个标准的不同数值
*/
select itemid ,count(*) from chartevents where (itemid=676 or itemid=677) and valuenum<36 group by itemid;


/*
筛选温度异常的病人数据
*/
select * from chartevent where item_id=223762 and valuenum>38 or valuenum<36 ;

select * from chartevent where item_id=223762 and valuenum>38 or valuenum<36 ;

/*
筛选幼稚细胞（BLASTS）数据，有
51346,由于所占比例90%以上，单取该数据便可
51443
51113
51148
列出的数据
*/
select itemid ,count(*) from labevents 
where (itemid in (51346,51443,51113,51148)) and valuenum<36 group by itemid;
/*
筛选白细胞（wbc）数据，有labevents 和 chartevents的区别需要比较
*/



select itemid, count(*) from labevents as lab
where lab.itemid = ANY (select itemid from d_labitems where label like '%WBC%') group by itemid;


SELECT itemid  FROM 
chartevent INNER JOIN (select itemid from d_labitems where  label like '%WBC%' as s)
ON chartevent.itemid = s.itemid;

/*
筛选sofa评分表
*/


/*
将各个数据都记录下来，最后通过

*/


/*
在多个表中寻找，符合两个条件及以上的数据
*/



/*
检查数据中的数据，lab和chart中是否有重复的病人
*/
select subject_id from 
chartevents inner join labevents
on chartevents.subject_id=labevents.subject_id;




   
   


















