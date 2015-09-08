class iqss::dataverse::config {

  jvmoption {
    $iqss::dataverse::glassfish_jvmoption:
      ensure => present,
  }

  jvmoption {
    [
      "-Ddataverse.auth.password-reset-timeout-in-minutes=${iqss::dataverse::dataverse_auth_password_reset_timeout_in_minutes}",
      "-Ddataverse.files.directory=${iqss::dataverse::dataverse_files_directory}",
      "-Ddataverse.fqdn=${iqss::params::dataverse_fqdn}" ,
      "-Ddataverse.rserve.host=${iqss::dataverse::dataverse_rserve_host}" ,
      "-Ddataverse.rserve.password=${iqss::dataverse::dataverse_rserve_password}" ,
      "-Ddataverse.rserve.port=${iqss::dataverse::dataverse_rserve_port}" ,
      "-Ddataverse.rserve.user=${iqss::dataverse::dataverse_rserve_user}" ,
      "-Ddataverse.siteUrl=${iqss::dataverse::dataverse_site_url}" ,
      "-Ddoi.baseurlstring=${iqss::dataverse::doi_baseurlstring}",
      "-Ddoi.password=${iqss::dataverse::doi_password}",
      "-Ddoi.username=${iqss::dataverse::doi_username}",
    ]:
      ensure => present;
  }

  jdbcconnectionpool {
    'dvnDbPool':
      ensure      => present,
      resourcetype=>  'javax.sql.DataSource',
      dsclassname => 'org.postgresql.ds.PGPoolingDataSource',
      properties  => "create=true:User=${iqss::params::database_user}:PortNumber=${iqss::params::database_port}:databaseName=${iqss::params::database_name}:password=${iqss::params::database_password}:ServerName=${iqss::params::database_host}",
  }

  jdbcresource  {
    'jdbc/VDCNetDS':
      ensure         => present,
      connectionpool => 'dvnDbPool',
  }

  javamailresource {
    'mail/notifyMailSession':
      ensure      => present,
      mailhost    => $iqss::dataverse::glassfish_mailhost,
      mailuser    => $iqss::dataverse::glassfish_mailuser,
      fromaddress => $iqss::dataverse::glassfish_fromaddress,
      properties  => $iqss::dataverse::glassfish_mailproperties,
  }

  networklistener {
    'jk-connector':
      ensure      => present,
      protocol    => 'http-listener-1',
      port        => 8009,
      jkenabled   => true,
  }

  connectorconnectionpool
  { 'jms/IngestQueueConnectionFactoryPool':
    ensure               => present,
    raname               => 'jmsra',
    connectiondefinition => 'javax.jms.QueueConnectionFactory',
    steadypoolsize       => 1,
    maxpoolsize          => 250,
    poolresize           => 2,
    maxwait              => 60000,
  }

  connectorresource {
    'jms/IngestQueueConnectionFactory':
      ensure      => present,
      poolname    =>  'jms/IngestQueueConnectionFactoryPool',
      description => 'ingest connector resource',
  }

  adminobject {
    'jms/DataverseIngest':
      ensure       => present,
      restype      =>  'javax.jms.Queue',
      raname       => 'jmsra',
      description  => 'sample administered object',
      properties   => 'Name=DataverseIngest',
  }

  set {
    'configs.config.server-config.ejb-container.ejb-timer-service.timer-datasource':
      ensure => present,
      value  => 'jdbc/VDCNetDS';
    'server-config.network-config.protocols.protocol.http-listener-1.http.comet-support-enabled':
      ensure => present,
      value  => true;
  }

}