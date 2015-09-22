class iqss::dataverse::install {

  case $iqss::dataverse::glassfish_version {
    '8.4': {
      $pgdriver = "postgresql-${iqss::params::database_version}.jdbc4-latest.jar"
    }
    '9.0': {
      $pgdriver = "postgresql-${iqss::params::database_version}.jdbc4-latest.jar"
    }
    default: {
      $pgdriver = 'postgresql-9.1.jdbc4-latest.jar'
    }
  }

  file {
    '/usr/bin/asadmin':
      ensure  => file,
      mode    => 755,
      content => template('iqss/dataverse/asadmin.erb') ;
  }

  class { 'glassfish':
    require                          => File['/usr/bin/asadmin'],
    user                             => $iqss::dataverse::glassfish_user,
    version                          => $iqss::dataverse::glassfish_version,
    create_domain                    => $iqss::dataverse::glassfish_create_domain,
    parent_dir                       => $iqss::dataverse::glassfish_parent_dir,
    remove_default_domain            => $iqss::dataverse::glassfish_remove_default_domain,
    domain_name                      => $iqss::dataverse::glassfish_domain_name,
    tmp_dir                          => $iqss::dataverse::glassfish_tmp_dir,
    service_name                     => $iqss::dataverse::glassfish_service_name,
  }->file {
    'deployed':
      path=> "${iqss::dataverse::domain}/config/domain.deployed.xml",
      content => template('iqss/glassfish/domain.deployed.xml.erb'),
      owner   => $iqss::dataverse::glassfish_user;
    'undeployed':
      path=> "${iqss::dataverse::domain}/config/domain.undeployed.xml",
      content => template('iqss/glassfish/domain.undeployed.xml.erb'),
      owner   => $iqss::dataverse::glassfish_user;
    "${iqss::dataverse::glassfish_parent_dir}/.gfclient/":
      ensure => directory,
      owner  => $iqss::dataverse::glassfish_user;
    "${iqss::dataverse::home}/modules/weld-osgi-bundle.jar":
      ensure => present,
      owner  => $iqss::dataverse::glassfish_user,
      source => 'puppet:///modules/iqss/weld-osgi-bundle-patch.jar';
    "${iqss::dataverse::home}/modules/glassfish-grizzly-extra-all.jar":
      ensure => present,
      owner  => $iqss::dataverse::glassfish_user,
      source => 'puppet:///modules/iqss/glassfish-grizzly-extra-all.jar';
    "${iqss::dataverse::domain}/config/jhove.conf":
      ensure => present,
      owner  => $iqss::dataverse::glassfish_user,
      source => 'puppet:///modules/iqss/dataverse/conf/jhove/jhove.conf';
    "${iqss::dataverse::home}/lib/${pgdriver}":
      ensure           => present,
      owner            => $iqss::dataverse::glassfish_user,
      source           => "puppet:///modules/iqss/pgdriver/$pgdriver";
    '/var/log/glassfish':
      ensure => link,
      target => "${iqss::dataverse::domain}/logs";
  }

  exec {
    'Create the files directory': # We use an exec rather than a file type, because the path may have subdirectories.
      require          => Class['glassfish'],
      command          => "/bin/mkdir -p ${iqss::dataverse::files_directory} && chown -R ${iqss::dataverse::glassfish_user}:${iqss::dataverse::glassfish_user} ${iqss::dataverse::files_directory}",
      creates          => $iqss::dataverse::files_directory;
  }

}