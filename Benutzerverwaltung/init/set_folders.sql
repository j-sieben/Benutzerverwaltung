-- Script to set the folder structure
-- Parameters
-- install folder containing the install.sql file to execute without trailing slash

define install_dir=&1./
define tool_dir=tools/
define pkg_dir=&install_dir.packages/
define view_dir=&install_dir.views/
define table_dir=&install_dir.tables/
define mv_dir=&install_dir.materialized_view/
define type_dir=&install_dir.types/
define seq_dir=&install_dir.sequences/
define script_dir=&install_dir.scripts/
define apex_dir=&install_dir.apex/&APEX_VERSION./