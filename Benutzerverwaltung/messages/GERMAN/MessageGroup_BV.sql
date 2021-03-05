begin

  pit_admin.merge_message_group(
    p_pmg_name => 'BV',
    p_pmg_description => q'^Meldungen für die Berechtigungsverwaltung^');

  pit_admin.merge_message(
    p_pms_name => 'BV_INVALID_DATE_PERIOD',
    p_pms_pmg_name => 'BV',
    p_pms_text => q'^Der Gültigkeistbeginn muss vor dem Gültigkeitsende liegen.^',
    p_pms_description => q'^Der Beginn des Gültigkeitsbandes liegt hinter dem Ende. Das ist nicht logisch und wird unterbunden.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'BV_INVALID_VALID_FROM',
    p_pms_pmg_name => 'BV',
    p_pms_text => q'^Der Gültigkeistbeginn darf nicht in der Vergangenheit liegen.^',
    p_pms_description => q'^Wenn ein neuer Benutzer angelegt wird, darf dessen Gültigkeitsbeginn nicht in der Vergangenheit liegen.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'BV_INVALID_BOOLEAN',
    p_pms_pmg_name => 'BV',
    p_pms_text => q'^Nur die Werte "&C_TRUE." und "&C_FALSE." sind erlaubt.^',
    p_pms_description => q'^Boolesche Werte müssen in dem für die Installation hinterlegten Format übergeben werden.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);

  pit_admin.merge_message(
    p_pms_name => 'BV_OBJECT_MISSING',
    p_pms_pmg_name => 'BV',
    p_pms_text => q'^#1# "#2#" existiert nicht.^',
    p_pms_description => q'^Das angefragte Objekt muss als Datenbankobjekt existieren.^',
    p_pms_pse_id => 30,
    p_pms_pml_name => 'GERMAN',
    p_error_number => -20000);


  commit;
  pit_admin.create_message_package;
end;
/