-- ------------------------------------------------------------------
-- Title: SQL clean script called by "make clean"
-- Description: Drops all materialized views re: severity scores
-- ------------------------------------------------------------------

DROP MATERIALIZED VIEW IF EXISTS APSIII CASCADE;
DROP MATERIALIZED VIEW IF EXISTS LODS CASCADE;
DROP MATERIALIZED VIEW IF EXISTS MLODS CASCADE;
DROP MATERIALIZED VIEW IF EXISTS OASIS CASCADE;
DROP MATERIALIZED VIEW IF EXISTS QSOFA CASCADE;
DROP MATERIALIZED VIEW IF EXISTS SAPS CASCADE;
DROP MATERIALIZED VIEW IF EXISTS SAPSII CASCADE;
DROP MATERIALIZED VIEW IF EXISTS SIRS CASCADE;
DROP MATERIALIZED VIEW IF EXISTS SOFA CASCADE;
