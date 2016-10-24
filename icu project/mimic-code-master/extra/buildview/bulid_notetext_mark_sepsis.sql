CREATE MATERIALIZED VIEW mimiciii.notetext as
with tit as
(
	select row_id, subject_id, hadm_id,text
	from mimiciii.noteevents
	where category = 'Discharge summary'
)
select row_id, subject_id, hadm_id,substring(text from 'PAST MEDICAL HISTORY:\n[^:]+|Past Medical History:\n[^:]+') as newtxt
from tit ;