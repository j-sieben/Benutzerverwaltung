
prompt &s1.Create Tables
@&table_dir.BV_ANREDE.sql
@&table_dir.BV_ANWENDUNG.sql
@&table_dir.BV_ANWENDUNG_ART.sql
@&table_dir.BV_ANWENDUNG_REFERENZ.sql
@&table_dir.BV_BENUTZER.sql
@&table_dir.BV_BENUTZER_RECHT.sql
@&table_dir.BV_BENUTZER_ROLLE.sql
@&table_dir.BV_RECHT.sql
@&table_dir.BV_ROLLE.sql
@&table_dir.BV_ROLLE_RECHT.sql
@&table_dir.BV_ROLLE_ROLLE.sql
@&table_dir.BV_TITEL.sql
@&table_dir.BV_ANWENDUNG_REFERENZ_PK.sql

prompt &s1.Create Indexes
@&table_dir.IDX_ANW_AAR_ID_FK.sql
@&table_dir.IDX_ARF_ANW_ID_FK.sql
@&table_dir.IDX_ARF_REFERENZ_ANW_ID_FK.sql
@&table_dir.IDX_BEN_ANR_ID_FK.sql
@&table_dir.IDX_BEN_TIT_ID_FK.sql
@&table_dir.IDX_BEN_AD_UPPER.sql
@&table_dir.IDX_BRE_REC_ID_FK.sql
@&table_dir.IDX_BRO_ROL_ID_FK.sql
@&table_dir.IDX_REC_ANW_ID_FK.sql
@&table_dir.IDX_ROL_ANW_ID_FK.sql
@&table_dir.IDX_RRE_REC_ID_FK.sql
@&table_dir.IDX_RRO_PARENT_ID_FK.sql

prompt &s1.Create Trigger
@&table_dir.TRG_BV_ANREDE_BRIU.sql
@&table_dir.TRG_BV_ANWENDUNG_BRIU.sql
@&table_dir.TRG_BV_ANWENDUNG_ART_BRIU.sql
@&table_dir.TRG_BV_BENUTZER_BRIU.sql
@&table_dir.TRG_BV_RECHT_BRIU.sql
@&table_dir.TRG_BV_ROLLE_BRIU.sql
@&table_dir.TRG_BV_TITEL_BRIU.sql

prompt &s1.Create Constraints
@&table_dir.BV_ANREDE_CONSTRAINT.sql
@&table_dir.BV_ANWENDUNG_CONSTRAINT.sql
@&table_dir.BV_ANWENDUNG_ART_CONSTRAINT.sql
@&table_dir.BV_ANWENDUNG_REFERENZ_CONSTRAINT.sql
@&table_dir.BV_BENUTZER_CONSTRAINT.sql
@&table_dir.BV_BENUTZER_RECHT_CONSTRAINT.sql
@&table_dir.BV_BENUTZER_ROLLE_CONSTRAINT.sql
@&table_dir.BV_RECHT_CONSTRAINT.sql
@&table_dir.BV_ROLLE_CONSTRAINT.sql
@&table_dir.BV_ROLLE_RECHT_CONSTRAINT.sql
@&table_dir.BV_TITEL_CONSTRAINT.sql
