create or replace PACKAGE "UTL_APEX"
  authid definer
as
  /** Utility-Methoden zur Verwendung im Umfeld von APEX
   */


  /** PL/SQL-Tabelle zur Uebergabe von Sessionstatus-Werten der aktuellen Anwendungsseite
   */
  type page_value_tab is table of varchar2(32767) index by varchar2(30);


  /** Prozedur zum Herunterladen eines BLOB ueber den Browser
   * %param p_blob BLOB-Instanz, die heruntergeladen werden soll
   * %param p_file_name Dateiname der Datei, die heruntergeladen werden soll
   * %usage Wird verwendet, um eine BLOB-Instanz aus der Datenbank ueber den
   *        Browser auf einen Client-PC zu laden
   */
  procedure download_blob(
    p_blob in out nocopy blob,
    p_file_name in varchar2);


  /** Prozedur zum Herunterladen eines CLOB ueber den Browser
   * %param p_blob CLOB-Instanz, die heruntergeladen werden soll
   * %param p_file_name Dateiname der Datei, die heruntergeladen werden soll
   * %usage Wird verwendet, um eine CLOB-Instanz aus der Datenbank ueber den
   *        Browser auf einen Client-PC zu laden
   */
  procedure download_clob(
    p_clob in clob,
    p_file_name in varchar2);


  /* Methode zum Auslesen aller Elementwerte einer APEX-Anwendungsseite
   * %return PL/SQL-Tabelle mit den Elementwerten, Zugriff erfolgt ueber den
   *         Elementnamen
   * %usage Generisches Utility, um alle Werte der aktuellen Anwendungsseite
   *        in eine Datenstruktur zu uebernehmen. Von hier aus koennen die
   *        Werte entweder direkt verwendet oder typsicher auf einen lokalen
   *        Record verteilt werden.
   */
  function get_page_values
    return page_value_tab;


  /* Methode zum Auslesen aller Elementwerte einer APEX-Anwendungsseite
   * %param  p_row_type  Name der View oder Tablle, die den Typ des Records repraesentiert
   * %return Anonymer PL/SQL-Block, der eine OUT-Variable eines Records typsicher
   *         mit den Zeilenwerten fuellt
   * %usage  Generisches Utility, um alle Werte der aktuellen Anwendungsseite
   *         in eine Datenstruktur zu uebernehmen. Von hier aus koennen die
   *         Werte entweder direkt verwendet oder typsicher auf einen lokalen
   *         Record verteilt werden.
   */
  function get_page_values(
    p_row_type in varchar2)
    return varchar2;


  /* Methode zum Auslesen der aktuellen Zeile eines APEX interaktiven Grids
   * %param  p_row_type   Name der View oder Tablle, die den Typ des Records repraesentiert
   * %param [p_static_id] Statische ID des interaktiven Grids (IG). Optional, ist nur erforderlich, 
   *                      wenn mehr als ein interaktives Grid auf der Seite exisitiert
   * %return Anonymer PL/SQL-Block, der eine OUT-Variable eines Records typsicher
   *         mit den Zeilenwerten fuellt
   * %usage  Generisches Utility, um alle Werte der aktuellen Zeile des IG
   *         in eine Datenstruktur zu uebernehmen. Von hier aus koennen die
   *         Werte entweder direkt verwendet oder typsicher auf einen lokalen
   *         Record verteilt werden.
   */
  function get_ig_values(
    p_row_type in varchar2,
    p_static_id in varchar2 default null)
    return varchar2;


  /* Funktion zum Lesen eines Seitenlementwerts aus einer Instang von PAGE_VALUE_TAB
   * %param p_page_values Instanz der Seitenwerte
   * %param p_element_name Name des Seitenelements
   * %return Sessionstatuswert
   * %usage Wrapper, wird verwendet, um sprechende Fehlermeldung bei nicht vorhandenen
   *        Seitenelementen zu generieren.
   */
  function get_value(
    p_page_values in page_value_tab,
    p_element_name in varchar2)
    return varchar2;


  /* Funktion zur Ermittlung des aktuellen Seitenpraefixes
   * %return Aktuelle Seitennummer der APEX-ANwenudng, als Praefix in der Form
   *         Pnn_
   */
  function get_page
    return varchar2;

  /* Funktion zur Analyse des Requests auf Loesch-, Aktualisierungs- oder Einfuegeoperationen
   * %return TRUE, falls die entsprechende Aktion aktuell angefordert wurde
   * %usage Mappt eine interne Liste von Requests auf die entsprechende Aktion.
   *        Kann verwendet werden, um in einer generischen Seitenverarbeitungsoperation
   *        auf eine explizite Pruefung des Requests zu verzichten
   */
  function inserting
    return boolean;

  function updating
    return boolean;

  function deleting
    return boolean;


  /* Prozedur erzeugt einen URL auf einen modalen Dialog, basierend auf einem Elementwert und legt
     den erzeugten URL in einem Hidden-Field auf der Seite ab
   * %param p_value_item Element(e), dass einen zu uebergebenden Wert enthaelt.
            Sollen mehrere Elemente uebergeben werden, muessen diese dem APEX-Prozess
            mitgegeben und hier ueber eine Komma-separierte Liste referenziert werden
   * %param p_hidden_item Element, das den generierten URL auf der Seite speichert
   * %param p_url_template Basisteil des URL, im Regelfall in der Form <APP_ALIAS>:<PAGE_ALIAS>
   * %usage Wird verwendet, um dynamisch einen modalen Dialo zu oeffnen. Das Problem ist,
            das Sessionstatuselemente uebergeben werden koennen, die zum Zeitpunkt des
            Renderns der Seite nicht bekannt sind. Daher muss der URL dynamisch
            berechnet und in einem Hidden-Field abgelegt werden.
   */
  procedure create_modal_dialog_url(
    p_value_item in varchar2,
    p_hidden_item in varchar2,
    p_url_template in varchar2);


  /* Methode zur Ermittlung des Authorisierungsstatus fuer eine Autorisierung
   * %param p_authorization_scheme Rolle, deren Zuordnung geprueft werden soll
   * %return Flag, das anzeigt, ob die Rolle erteilt wurde (1) oder nicht (0)
   * %usage Wird verwendet, um als generische Loesung die ACL-Funktionalitaet
   *        von APEX auszubauen
   */
  function get_authorization_status_for(
    p_authorization_scheme in varchar2)
    return number;


  /* Prozedur erstellt eine APEX-Session ohne Browserbeteiligung
   * %param p_application_id ID der Anwendung, fuer die eine Session erstellt werden soll
   * %param p_apex_user Name des APEX-Benutzers, fuer den eine Session erstellt werden soll
   * %param p_page_id Optionale Angabe einer Seitennummer, auf die sich die folgenden Eingaben
            beziehen sollen
   * %usage Wird verwendet, um bei Tests von APEX-Komponenten keine Weboberflaeche verwenden
            zu muessen
   */
  procedure create_apex_session(
    p_application_id in apex_applications.application_id%type,
    p_apex_user in apex_workspace_activity_log.apex_user%type,
    p_page_id in apex_application_pages.page_id%type default 1);

end;

/

create or replace PACKAGE BODY "UTL_APEX"
as

  c_pkg constant varchar2(30 byte) := $$PLSQL_UNIT;


  function clob_to_blob(
    p_clob in clob)
    return blob
  as
    l_blob blob;
    l_lang_context  integer := dbms_lob.DEFAULT_LANG_CTX;
    l_warning       integer := dbms_lob.WARN_INCONVERTIBLE_CHAR;
    l_dest_offset   integer := 1;
    l_source_offset integer := 1;
  begin
    --pit.enter_detailed('clob_to_blob', c_pkg);

    dbms_lob.createtemporary(l_blob, true, dbms_lob.call);
      dbms_lob.converttoblob (
        dest_lob => l_blob,
        src_clob => p_clob,
        amount => dbms_lob.LOBMAXSIZE,
        dest_offset => l_dest_offset,
        src_offset => l_source_offset,
        blob_csid => dbms_lob.DEFAULT_CSID,
        lang_context => l_lang_context,
        warning => l_warning
      );

    --pit.leave_detailed;
    return l_blob;
  end clob_to_blob;


  procedure download_blob(
    p_blob in out nocopy blob,
    p_file_name in varchar2)
  as
  begin
    /*pit.enter_optional(
      p_action => 'download_blob',
      p_module => c_pkg,
      p_params => msg_params(msg_param('p_file_name', p_file_name)));*/

    htp.init;
    owa_util.mime_header('application/octet-stream', FALSE, 'UTF-8');
    htp.p('Content-length: ' || dbms_lob.getlength(p_blob));
    htp.p('Content-Disposition: inline; filename="' || p_file_name || '"');
    owa_util.http_header_close;
    wpg_docload.download_file(p_blob);
    apex_application.stop_apex_engine;

    --pit.leave_optional;
  exception when others then
    htp.p('error: ' || sqlerrm);
    apex_application.stop_apex_engine;
    --pit.leave_optional;
  end download_blob;


  procedure download_clob(
    p_clob in clob,
    p_file_name in varchar2)
  as
    l_blob blob;
  begin
    /*pit.enter_optional(
      p_action => 'download_clob',
      p_module => c_pkg,
      p_params => msg_params(msg_param('p_file_name', p_file_name)));*/

    l_blob := clob_to_blob(p_clob);
    download_blob(l_blob, p_file_name);

    --pit.leave_optional;
  end download_clob;


  function get_page_values
    return page_value_tab
  as
    cursor item_cur(p_application_id in number, p_page_id in number) is
      select item_name,
             -- Entferne Abhaengigkeit von Seitennummer aus Elementnamen
             substr(item_name, instr(item_name, '_') + 1) item_short_name
        from apex_application_page_items
       where application_id = p_application_id
         and page_id = p_page_id;
    l_page_values page_value_tab;
  begin
    for itm in item_cur(v('APP_ID'), v('APP_PAGE_ID')) loop
      l_page_values(itm.item_short_name) := v(itm.item_name);
    end loop;
    return l_page_values;
  end get_page_values;


  function get_page_values(
    p_row_type in varchar2)
    return varchar2
  as
   cursor item_cur(p_row_type in varchar2) is
        with params as (
             select upper(p_row_type) table_name,
                    v('APP_ID') application_id,
                    v('APP_PAGE_ID') page_id,
                    'P' || v('APP_PAGE_ID') || '_' page_prefix
               from dual)
      select /*+ NO_MERGE /p) */
             item_name, c.column_name, c.data_type,
             case c.data_type
             when 'DATE' then replace(replace(q'^to_date(v('#ITEM_NAME#'), '#FORMAT_MASK#')^',
                                '#ITEM_NAME#', i.item_name),
                                '#FORMAT_MASK#', coalesce(i.format_mask, a.date_format))
             when 'NUMBER' then replace(replace(q'^to_number(v('#ITEM_NAME#'), '#FORMAT_MASK#')^',
                                  '#ITEM_NAME#', i.item_name),
                                  '#FORMAT_MASK#', coalesce(replace(i.format_mask, 'G'), 'fm9999999999999999999D999999'))
             else replace(q'^v('#ITEM_NAME#')^', '#ITEM_NAME#', i.item_name) end item_value
        from apex_application_page_items i
        join params p
          on i.application_id = p.application_id
         and i.page_id = p.page_id
        join apex_applications a
          on i.application_id = a.application_id
        join user_tab_columns c
          on replace(i.item_name, p.page_prefix) = c.column_name
         and c.table_name = p.table_name;
    c_cr constant varchar2(1) := chr(10);
    c_stmt_template constant varchar2(100) := 
      q'^declare#CR#  g_row #ROWTYPE#%rowtype;#CR#begin#CR##COLUMNS##CR#  :x := g_row;#CR#end;^';
    c_column_template constant varchar2(100) := 
      q'^  g_row.#COLUMN_NAME# := #ITEM_VALUE#;#CR#^';
    l_stmt varchar2(32767);
    l_columns varchar2(32767);
  begin
    for itm in item_cur(p_row_type) loop
      l_columns := l_columns 
                || replace(replace(replace(c_column_template,
                     '#COLUMN_NAME#', itm.column_name),
                     '#ITEM_VALUE#', itm.item_value),
                     '#CR#', c_cr);
    end loop;
    l_stmt := replace(replace(replace(c_stmt_template,
                '#ROWTYPE#', p_row_type),
                '#COLUMNS#', l_columns),
                '#CR#', c_cr);
    return l_stmt;
  end get_page_values;


  function get_ig_values(
    p_row_type in varchar2,
    p_static_id in varchar2 default null)
    return varchar2
  as
    cursor ig_columns(p_static_id in varchar2) is
        with params as(
             select v('APP_ID') app_id,
                    v('APP_PAGE_ID') page_id
               from dual)
      select /*+ NO_MERGE (p) */
             '  g_row.' || name || ' := ' ||
             case data_type
             when 'DATE' then 'to_date(v(''' || name || '''), ''' || coalesce(format_mask, a.date_format) || ''');'
             when 'NUMBER' then 'to_number(v(''' || name || ''')' || nvl2(format_mask, ', ''' || format_mask || ''');', ');')
             else 'v(''' || name || ''');' end value_string
        from apex_appl_page_ig_columns ig
        join params p
          on ig.application_id = p.app_id
         and ig.page_id = p.page_id
        join apex_application_page_regions r
          on ig.region_id = r.region_id
        join apex_applications a
          on r.application_id = a.application_id
       where ig.source_type_code = 'DB_COLUMN'
         and (r.static_id = p_static_id or p_static_id is null);
    l_result varchar2(32767);
  begin
    l_result := q'^declare
  g_row #TABLE#%rowtype;
begin
^';
    l_result := replace(l_result, '#TABLE#', p_row_type);
    for col in ig_columns(p_static_id) loop
      l_result := l_result || col.value_string || chr(13);
    end loop;
    l_result := l_result || '  :x := g_row;' || chr(13) || 'end;';
    return l_result;
  end get_ig_values;


  function get_page
    return varchar2
  as
    c_page_template constant varchar2(100) := 'P#PAGE#_';
  begin
    return replace(c_page_template, '#PAGE#', v('APP_ID'));
  end get_page;


  function get_value(
    p_page_values in page_value_tab,
    p_element_name in varchar2)
    return varchar2
  as
  begin
    return p_page_values(p_element_name);
  exception
    when no_data_found then
      raise_application_error(-20000, 'Element ' || p_element_name || ' existiert nicht auf der APEX-Seite');
      --pit.stop(msg.UTL_APEX_ITEM_MISSING, msg_args(p_element_name, v('APP_ID')));
  end get_value;


  function get_request
    return varchar2
  as
    l_request varchar2(30) := v('REQUEST');
  begin
    case l_request
    when 'APEX_AJAX_DISPATCH' then
      return v('APEX$ROW_STATUS');
    else
      return l_request;
    end case;
  end get_request;


  function inserting
    return boolean
  as
  begin
    return get_request in ('CREATE', 'C');
  end inserting;


  function updating
    return boolean
  as
  begin
    return get_request in ('SAVE', 'U');
  end updating;


  function deleting
    return boolean
  as
  begin
    return get_request in ('DELETE', 'D');
  end deleting;


  procedure create_modal_dialog_url(
    p_value_item in varchar2,
    p_hidden_item in varchar2,
    p_url_template in varchar2)
  as
    l_value_item_tab wwv_flow_global.vc_arr2;
    l_param_values varchar2(32767);
    l_url varchar2(32767);
    c_url_template constant varchar2(100) := q'^f?p=#URL_TEMPLATE#::::#PARAMS#:#PARAM_VALUES#^';
  begin
    l_value_item_tab := apex_util.string_to_table (
                          p_string => p_value_item,
                          p_separator => ',');
    for i in l_value_item_tab.first .. l_value_item_tab.last loop
      if i > 1 then
        l_param_values := l_param_values || ',';
      end if;
      l_param_values := l_param_values || v(l_value_item_tab(i));
    end loop;
    l_url := replace(replace(replace(c_url_template,
                 '#UTL_TEMPLATE#', p_url_template),
                 '#PARAMS#', p_value_item),
                 '#PARAM_VALUES#', l_param_values);
    apex_util.set_session_state(p_hidden_item, apex_util.prepare_url(l_url));
  end create_modal_dialog_url;


  function get_authorization_status_for(
    p_authorization_scheme in varchar2)
    return number
  as
  begin
    if apex_util.public_check_authorization(p_authorization_scheme) then
      return 1;
    else
      return 0;
    end if;
  end get_authorization_status_for;


  procedure create_apex_session(
    p_application_id in apex_applications.application_id%type,
    p_apex_user in apex_workspace_activity_log.apex_user%type,
    p_page_id in apex_application_pages.page_id%type default 1)
  as
    l_workspace_id apex_applications.workspace_id%type;
    l_param_name owa.vc_arr;
    l_param_val owa.vc_arr;
  begin
    htp.init;
    l_param_name(1) := 'REQUEST_PROTOCOL';
    l_param_val(1) := 'HTTP';

    owa.init_cgi_env(
      num_params => 1,
      param_name => l_param_name,
      param_val =>l_param_val);

    select workspace_id
      into l_workspace_id
      from apex_applications
     where application_id = p_application_id;

    wwv_flow_api.set_security_group_id(l_workspace_id);

    apex_application.g_instance := 1;
    apex_application.g_flow_id := p_application_id;
    apex_application.g_flow_step_id := p_page_id;

    apex_custom_auth.post_login(
      p_uname => p_apex_user,
      p_session_id => apex_custom_auth.get_next_session_id,
      p_app_page => apex_application.g_flow_id || ':' || p_page_id);

  end create_apex_session;

end;
/
