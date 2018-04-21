--------------------------------------------------------
--  DDL for Package UI_ADMIN_BEN_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "UI_ADMIN_BEN_PKG" 
  authid definer
as
  /* Das Package verwaltet die UI-Views UI_ADMIN_BEN*
   * %ui
   */
     
  function validate_admin_ben
    return boolean;
   
  procedure handle_admin_ben;
   
  procedure handle_admin_ben_ig;

end ui_admin_ben_pkg;

/
