--------------------------------------------------------
--  DDL for Package UI_ADMIN_ROL_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "UI_ADMIN_ROL_PKG" 
  authid definer
as
  /* Das Package verwaltet die UI-Views UI_ADMIN_ROL*
   * %ui
   */
   
  function get_hierarchie_url
    return varchar2;
   
  procedure validate_admin_rol;
  
  procedure handle_admin_rol;
  
  
  procedure handle_admin_einfache_rol(
    p_anw_id in bv_anwendung.anw_id%type,
    p_rol_rol_shuttle ui_admin_einfache_rol_shuttle.rol_rol_shuttle%type);

end ui_admin_rol_pkg;

/
