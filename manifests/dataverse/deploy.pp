class iqss::dataverse::deploy {

  $path = "${iqss::dataverse::glassfish_parent_dir}/glassfish-${iqss::dataverse::glassfish_version}/bin:/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin"

  exec {
    'deploy':
      command => "asadmin undeploy dataverse ; asadmin deploy /usr/src/dataverse.war",
      path    => $path,
      creates => "${iqss::dataverse::glassfish_parent_dir}/glassfish-${iqss::dataverse::glassfish_version}/glassfish/domains/${iqss::dataverse::glassfish_domain_name}/applications/dataverse",
      notify  => Exec['ingest sql', 'ingest api'] ;
  }


  exec {
    'ingest sql':
      command => 'sudo -u dvnApp psql dvndb -f reference_data.sql',
      cwd     => '/opt/dataverse/scripts/database/',
      onlyif  => 'test -f /usr/bin/psql', # Typically these sql installation commands will not work if the database is not on this machine.
      path    => $path ;
  }

  exec {
    'ingest api':
      command => '/opt/dataverse/scripts/api/setup-all.sh && /opt/dataverse/scripts/api/post-install-api-block.sh',
      cwd     => '/opt/dataverse/scripts/api/',
      path    => $path ;
  }

}