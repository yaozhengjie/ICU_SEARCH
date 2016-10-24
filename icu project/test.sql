
create 

CREATE OR REPLACE FUNCTION totalRecords ()
RETURNS integer AS $total$
declare
	total integer;
BEGIN
   SELECT count(*) into total FROM sepsis10qq_18;
   RETURN total;
END;
$total$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION increment(i integer) 
RETURNS integer AS $$
BEGIN
	RETURN i + 1;
END;
$$ LANGUAGE plpgsql;

create or replace function increment(i integer)
returns integer as $$
begin 
	return i + 1;
end;
$$ language plpgsql;

 CREATE TABLE COMPANY(
   ID INT PRIMARY KEY     NOT NULL,
   NAME           TEXT    NOT NULL,
   AGE            INT     NOT NULL,
   ADDRESS        CHAR(50),
   SALARY         REAL
);  
CREATE TRIGGER example_trigger AFTER INSERT ON admissions
FOR EACH ROW EXECUTE PROCEDURE sum(); 


\copy (select * from biaoge) to '/home/yzj/wenjian.csv' with delimiter ',' csv header




select * from tableA
left outer join tableB
on tableA.name = tableB.name 
where tableB.id is null
--选择了没有id的数据


select * from tableA
full outer join tableB
on tableA.name = tableB.name 
where tableA.id is null
or tableB.id is null


select * from noteevents where 
    case
      when substring(ne.text, 'Height: \(in\) (.*?)\n') like '%*%'
        then null
      else cast(substring(ne.text, 'Height: \(in\) (.*?)\n') as numeric)
    end as Height









