class iqss::dataverse::deploy {

  $path = "${iqss::dataverse::glassfish_parent_dir}/glassfish-${iqss::dataverse::glassfish_version}/bin:/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin"

  exec {
    'deploy':
      command => "asadmin undeploy dataverse ; asadmin deploy /usr/src/${iqss::dataverse::package}.war",
      path    => $path,
      creates => "${iqss::dataverse::glassfish_parent_dir}/glassfish-${iqss::dataverse::glassfish_version}/glassfish/domains/${iqss::dataverse::glassfish_domain_name}/applications/${iqss::dataverse::package}",
      notify  => Exec['ingest_sql', 'ingest_api'] ;
  }


  # Placing a firstrun file is kind of a workaround the problem: how do we know our dataverse is populated with data ?
  exec {
    'ingest_sql':
      command => 'sudo -u dvnApp psql dvndb -f reference_data.sql && touch /opt/ingest_sql.firstrun',
      cwd     => '/opt/dataverse/scripts/database/',
      onlyif  => 'test -f /usr/bin/psql', # Typically these sql installation commands will not work if the database is not on this machine.
      unless  => 'test -f /opt/ingest_sql.firstrun', # We do not want to repeat the insert on every run.',
      path    => $path ;
  }

  exec {
    'ingest_api':
      command => '/opt/dataverse/scripts/api/setup-all.sh && /opt/dataverse/scripts/api/post-install-api-block.sh && touch /opt/ingest_api.firstrun',
      cwd     => '/opt/dataverse/scripts/api/',
      unless  => 'test -f /opt/ingest_api.firstrun',
      path    => $path ;
  }

}