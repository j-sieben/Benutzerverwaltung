--------------------------------------------------------
--  DDL for Package Body BV_RECHT_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "BV_RECHT_PKG" as

  function aktueller_benutzer_hat_recht(
    p_rec_id in bv_recht.rec_id%type,
    p_anw_id in bv_anwendung.anw_id%type default null)
    return boolean
  as
  begin
    return bl_recht_pkg.aktueller_benutzer_hat_recht(p_rec_id, p_anw_id) = 'Y';
  end aktueller_benutzer_hat_recht;


  function aktueller_benutzer_ist(
    p_rol_id in bv_rolle.rol_id%type,
    p_anw_id in bv_anwendung.anw_id%type default null)
    return boolean
  as
  begin
    return bl_recht_pkg.aktueller_benutzer_ist(p_rol_id, p_anw_id) = 'Y';
  end aktueller_benutzer_ist;


  function benutzer_hat_recht(
    p_ben_ad in bv_benutzer.ben_ad%type,
    p_rec_id in bv_recht.rec_id%type,
    p_anw_id in bv_anwendung.anw_id%type default null)
    return boolean
  as
  begin
    return bl_recht_pkg.benutzer_hat_recht(p_ben_ad, p_rec_id, p_anw_id) = 'Y';
  end benutzer_hat_recht;


  function benutzer_ist(
    p_ben_ad in bv_benutzer.ben_ad%type,
    p_rol_id in bv_rolle.rol_id%type,
    p_anw_id in bv_anwendung.anw_id%type default null)
    return boolean
  as
  begin
    return bl_recht_pkg.benutzer_hat_recht(p_ben_ad, p_rol_id, p_anw_id) = 'Y';
  end benutzer_ist;

end bv_recht_pkg;

/
