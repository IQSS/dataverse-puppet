class iqss::dataverse::deploy {

  $path = "${iqss::dataverse::glassfish_parent_dir}/glassfish-${iqss::dataverse::glassfish_version}/bin:/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin"

  notify {
    "${iqss::dataverse::glassfish_parent_dir}/glassfish-${iqss::dataverse::glassfish_version}/glassfish/domains/${iqss::dataverse::glassfish_domain_name}/applications/dataverse":
  }->exec {
    'deploy':
      command => "asadmin deploy /usr/src/dataverse.war",
      path    => $path,
      creates => "${iqss::dataverse::glassfish_parent_dir}/glassfish-${iqss::dataverse::glassfish_version}/glassfish/domains/${iqss::dataverse::glassfish_domain_name}/applications/dataverse",
      notify  => Exec['ingest sql', 'ingest api'] ;
  }

# Typically these sql installation commands will not work if the database is not on this machine.
  exec {
    'ingest sql':
      command => 'sudo -u dvnApp psql dvndb -f reference_data.sql',
      cwd     => '/opt/dataverse/scripts/database/',
      path    => $path,
      onlyif  => 'test -f /usr/bin/psql' ;
  }

  exec {
    'ingest api':
      command => '/opt/dataverse/scripts/api/setup-all.sh && /opt/dataverse/scripts/api/post-install-api-block.sh',
      cwd     => '/opt/dataverse/scripts/api/',
      path    => $path ;
  }

}