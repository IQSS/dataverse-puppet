# = Puppet module for dataverse.
# == Class: Dataverse::Dataverse::Deploy
#
# === Copyright
#
# Puppet module for dataverse.
# GPLv3 - Copyright (C) 2015 International Institute of Social History <socialhistory.org>.
#
# === Description
#
# Private class. Do not use directly.
#
# Deploy the war and populate the database.

class dataverse::dataverse::deploy {

  $path = "${dataverse::dataverse::home}/bin:/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin"

  exec {
    'deploy':
      command => "asadmin undeploy ${dataverse::dataverse::_package} ; asadmin deploy --name ${dataverse::dataverse::_package} /usr/src/${dataverse::dataverse::_package}.war",
      path    => $path,
      creates => "${dataverse::dataverse::domain}/applications/${dataverse::dataverse::_package}",
      notify  => Exec['ingest_sql', 'ingest_api'] ;
  }


  # Placing a firstrun file is kind of a workaround the problem: how do we know our dataverse is populated with data ?
  # We should move this to Dataverse::Database
  exec {
    'ingest_sql':
      command => "sudo -u dvnApp psql dvndb -f reference_data.sql && touch /opt/ingest_sql.${dataverse::dataverse::_package}.firstrun",
      cwd     => '/opt/dataverse/scripts/database/',
      onlyif  => 'test -f /usr/bin/psql', # Typically these sql installation commands will not work if the database is not on this machine.
      unless  => "test -f /opt/ingest_sql.${dataverse::dataverse::_package}.firstrun", # We do not want to repeat the insert on every run.',
      path    => $path ;
  }

  exec {
    'ingest_api':
      command => "/opt/dataverse/scripts/api/setup-all.sh && /opt/dataverse/scripts/api/post-install-api-block.sh && touch /opt/ingest_api.${dataverse::dataverse::_package}.firstrun",
      cwd     => '/opt/dataverse/scripts/api/',
      unless  => "test -f /opt/ingest_api.${dataverse::dataverse::_package}.firstrun",
      path    => $path ;
  }

}