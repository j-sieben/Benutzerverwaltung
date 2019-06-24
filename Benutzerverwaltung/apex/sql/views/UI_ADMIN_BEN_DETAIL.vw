CREATE OR REPLACE EDITIONABLE VIEW UI_ADMIN_BEN_DETAIL AS 
select bro_ben_id,
       bro_rol_id,
       bro_anw_id,
       bro_gueltig_von,
       bro_gueltig_bis
  from bv_benutzer_rolle
  join table(bl_recht_pkg.get_admin_anw(v('APP_USER'), '&APEX_ALIAS.'))
    on bro_anw_id = column_value;

COMMENT ON COLUMN "UI_ADMIN_BEN_DETAIL"."BRO_BEN_ID" IS 'Primaerschluessel, Referenz auf BV_BENUTZER';
COMMENT ON COLUMN "UI_ADMIN_BEN_DETAIL"."BRO_ROL_ID" IS 'Primaerschluessel, Referenz auf BV_ROLLE';
COMMENT ON COLUMN "UI_ADMIN_BEN_DETAIL"."BRO_ANW_ID" IS 'Primaerschluessel, Referenz auf BV_ROLLE';
COMMENT ON COLUMN "UI_ADMIN_BEN_DETAIL"."BRO_GUELTIG_VON" IS 'Festlegung eines Gueltigkeitszeitraums';
COMMENT ON COLUMN "UI_ADMIN_BEN_DETAIL"."BRO_GUELTIG_BIS" IS 'Festlegung eines Gueltigkeitszeitraums';
COMMENT ON TABLE "UI_ADMIN_BEN_DETAIL"  IS 'UI-Wrapper der Seite ADMIN_BEN um BV_BENUTZER_ROLLE auf alle Anwendungsrechte, die durch den angemeldeten Benutzer editiert werden duerfen';
