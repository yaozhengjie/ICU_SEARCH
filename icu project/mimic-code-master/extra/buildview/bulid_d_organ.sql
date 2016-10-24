-- DROP MATERIALIZED VIEW mimiciii.d_organ;

CREATE MATERIALIZED VIEW mimiciii.d_organ AS 
 SELECT d_icd_diagnoses.row_id,
    d_icd_diagnoses.icd9_code,
    d_icd_diagnoses.short_title,
    d_icd_diagnoses.long_title
   FROM mimiciii.d_icd_diagnoses
  WHERE ("substring"(d_icd_diagnoses.icd9_code::text, 1, 3) = ANY (ARRAY['458'::text, '293'::text, '570'::text, '584'::text])) OR ("substring"(d_icd_diagnoses.icd9_code::text, 1, 4) = ANY (ARRAY['7855'::text, '3483'::text, '3481'::text, '2874'::text, '2875'::text, '2869'::text, '2866'::text, '5734'::text]))
WITH DATA;

ALTER TABLE mimiciii.d_organ
  OWNER TO postgres;