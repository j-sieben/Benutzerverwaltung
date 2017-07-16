--------------------------------------------------------
--  DDL for View UI_ADMIN_ARF
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "UI_ADMIN_ARF" ("ARF_ANW_ID", "ARF_ANW_ID_LIST") AS 
  select arf_anw_id,
       listagg(arf_referenz_anw_id, ':') within group (order by arf_anw_id) arf_anw_id_list
  from bv_anwendung_referenz
 where arf_referenz_anw_id != arf_anw_id
 group by arf_anw_id;

   COMMENT ON COLUMN "UI_ADMIN_ARF"."ARF_ANW_ID" IS 'Primaerschluessel, Referenz auf BV_ANWENDUNG, Anwendung, die eine Referenz auf andere Anwendungen hat';
   COMMENT ON COLUMN "UI_ADMIN_ARF"."ARF_ANW_ID_LIST" IS '":"-separierte Liste der Anwendungen, die durch ARF_ANW_ID referenziert werden. Gruppierung.';
   COMMENT ON TABLE "UI_ADMIN_ARF"  IS 'UI-Wrapper der Seite ADMIN_ARF fuer Tabelle BV_ANWENDUNG_REFERENZ. Aggregierende View, DML direkt ueber UI_ADMIN_ARF_PKG.'
;
