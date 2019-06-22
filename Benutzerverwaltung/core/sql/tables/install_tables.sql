
prompt &s1.Create Tables
prompt &s2.BV_ANREDE
@&table_dir.BV_ANREDE.sql
prompt &s2.BV_ANWENDUNG
@&table_dir.BV_ANWENDUNG.sql
prompt &s2.BV_ANWENDUNG_ART
@&table_dir.BV_ANWENDUNG_ART.sql
prompt &s2.BV_ANWENDUNG_REFERENZ
@&table_dir.BV_ANWENDUNG_REFERENZ.sql
prompt &s2.BV_BENUTZER
@&table_dir.BV_BENUTZER.sql
prompt &s2.BV_BENUTZER_RECHT
@&table_dir.BV_BENUTZER_RECHT.sql
prompt &s2.BV_BENUTZER_ROLLE
@&table_dir.BV_BENUTZER_ROLLE.sql
prompt &s2.BV_RECHT
@&table_dir.BV_RECHT.sql
prompt &s2.BV_ROLLE
@&table_dir.BV_ROLLE.sql
prompt &s2.BV_ROLLE_RECHT
@&table_dir.BV_ROLLE_RECHT.sql
prompt &s2.BV_ROLLE_ROLLE
@&table_dir.BV_ROLLE_ROLLE.sql
prompt &s2.BV_TITEL
@&table_dir.BV_TITEL.sql
prompt &s2.BV_ANWENDUNG_REFERENZ_PK
@&table_dir.BV_ANWENDUNG_REFERENZ_PK.sql

prompt &s1.Create Indexes
prompt &s2.IDX_ANW_AAR_ID_FK
@&table_dir.IDX_ANW_AAR_ID_FK.sql
prompt &s2.IDX_ARF_ANW_ID_FK
@&table_dir.IDX_ARF_ANW_ID_FK.sql
prompt &s2.IDX_ARF_REFERENZ_ANW_ID_FK
@&table_dir.IDX_ARF_REFERENZ_ANW_ID_FK.sql
prompt &s2.IDX_BEN_ANR_ID_FK
@&table_dir.IDX_BEN_ANR_ID_FK.sql
prompt &s2.IDX_BEN_TIT_ID_FK
@&table_dir.IDX_BEN_TIT_ID_FK.sql
prompt &s2.IDX_BEN_AD_UPPER
@&table_dir.IDX_BEN_AD_UPPER.sql
prompt &s2.IDX_BRE_REC_ID_FK
@&table_dir.IDX_BRE_REC_ID_FK.sql
prompt &s2.IDX_BRO_ROL_ID_FK
@&table_dir.IDX_BRO_ROL_ID_FK.sql
prompt &s2.IDX_REC_ANW_ID_FK
@&table_dir.IDX_REC_ANW_ID_FK.sql
prompt &s2.IDX_ROL_ANW_ID_FK
@&table_dir.IDX_ROL_ANW_ID_FK.sql
prompt &s2.IDX_RRE_REC_ID_FK
@&table_dir.IDX_RRE_REC_ID_FK.sql
prompt &s2.IDX_RRO_PARENT_ID_FK
@&table_dir.IDX_RRO_PARENT_ID_FK.sql

prompt &s1.Create Trigger
prompt &s2.TRG_BV_ANREDE_BRIU
@&table_dir.TRG_BV_ANREDE_BRIU.sql
prompt &s2.TRG_BV_ANWENDUNG_BRIU
@&table_dir.TRG_BV_ANWENDUNG_BRIU.sql
prompt &s2.TRG_BV_ANWENDUNG_ART_BRIU
@&table_dir.TRG_BV_ANWENDUNG_ART_BRIU.sql
prompt &s2.TRG_BV_BENUTZER_BRIU
@&table_dir.TRG_BV_BENUTZER_BRIU.sql
prompt &s2.TRG_BV_RECHT_BRIU
@&table_dir.TRG_BV_RECHT_BRIU.sql
prompt &s2.TRG_BV_ROLLE_BRIU
@&table_dir.TRG_BV_ROLLE_BRIU.sql
prompt &s2.TRG_BV_TITEL_BRIU
@&table_dir.TRG_BV_TITEL_BRIU.sql

prompt &s1.Create Constraints
prompt &s2.BV_ANREDE_CONSTRAINT
@&table_dir.BV_ANREDE_CONSTRAINT.sql
prompt &s2.BV_ANWENDUNG_CONSTRAINT
@&table_dir.BV_ANWENDUNG_CONSTRAINT.sql
prompt &s2.BV_ANWENDUNG_ART_CONSTRAINT
@&table_dir.BV_ANWENDUNG_ART_CONSTRAINT.sql
prompt &s2.BV_ANWENDUNG_REFERENZ_CONSTRAINT
@&table_dir.BV_ANWENDUNG_REFERENZ_CONSTRAINT.sql
prompt &s2.BV_BENUTZER_CONSTRAINT
@&table_dir.BV_BENUTZER_CONSTRAINT.sql
prompt &s2.BV_BENUTZER_RECHT_CONSTRAINT
@&table_dir.BV_BENUTZER_RECHT_CONSTRAINT.sql
prompt &s2.BV_BENUTZER_ROLLE_CONSTRAINT
@&table_dir.BV_BENUTZER_ROLLE_CONSTRAINT.sql
prompt &s2.BV_RECHT_CONSTRAINT
@&table_dir.BV_RECHT_CONSTRAINT.sql
prompt &s2.BV_ROLLE_CONSTRAINT
@&table_dir.BV_ROLLE_CONSTRAINT.sql
prompt &s2.BV_ROLLE_RECHT_CONSTRAINT
@&table_dir.BV_ROLLE_RECHT_CONSTRAINT.sql
prompt &s2.BV_TITEL_CONSTRAINT
@&table_dir.BV_TITEL_CONSTRAINT.sql
