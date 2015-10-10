# == Class: Iqss::Dataverse::Deploy
#
# Private class. Do not use directly.
#
class iqss::dataverse::deploy {

  $path = "${iqss::dataverse::home}/bin:/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin"

  exec {
    'deploy':
      command => "asadmin undeploy ${iqss::dataverse::package} ; asadmin deploy --name ${iqss::dataverse::package} /usr/src/${iqss::dataverse::package}.war",
      path    => $path,
      creates => "${iqss::dataverse::domain}/applications/${iqss::dataverse::package}",
      notify  => Exec['ingest_sql', 'ingest_api'] ;
  }


  # Placing a firstrun file is kind of a workaround the problem: how do we know our dataverse is populated with data ?
  # We should move this to Iqss::Database
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