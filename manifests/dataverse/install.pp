# = Puppet module for dataverse.
# == Class: Dataverse::Dataverse::Install
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
# Install Glassfish plus the application's dependencies like the database driver, jhove config and patches.

class dataverse::dataverse::install {

  case $dataverse::dataverse::glassfish_version {
    '8.4': {
      $pgdriver = "postgresql-${dataverse::database::database_version}.jdbc4-latest.jar"
    }
    '9.0': {
      $pgdriver = "postgresql-${dataverse::database::database_version}.jdbc4-latest.jar"
    }
    default: {
      $pgdriver = 'postgresql-9.1.jdbc4-latest.jar'
    }
  }

  file {
    '/usr/bin/asadmin':
      ensure  => file,
      mode    => 755,
      content => template('dataverse/dataverse/asadmin.erb') ;
  }

  class { 'glassfish':
    require                          => File['/usr/bin/asadmin'],
    user                             => $dataverse::dataverse::glassfish_user,
    version                          => $dataverse::dataverse::glassfish_version,
    create_domain                    => $dataverse::dataverse::glassfish_create_domain,
    parent_dir                       => $dataverse::dataverse::glassfish_parent_dir,
    remove_default_domain            => $dataverse::dataverse::glassfish_remove_default_domain,
    domain_name                      => $dataverse::dataverse::glassfish_domain_name,
    tmp_dir                          => $dataverse::dataverse::glassfish_tmp_dir,
    service_name                     => $dataverse::dataverse::glassfish_service_name,
  }->file {
    'deployed':
      path=> "${dataverse::dataverse::domain}/config/domain.deployed.xml",
      content => template('dataverse/dataverse/domain.deployed.xml.erb'),
      owner   => $dataverse::dataverse::glassfish_user;
    'undeployed':
      path=> "${dataverse::dataverse::domain}/config/domain.undeployed.xml",
      content => template('dataverse/dataverse/domain.undeployed.xml.erb'),
      owner   => $dataverse::dataverse::glassfish_user;
    "${dataverse::dataverse::glassfish_parent_dir}/.gfclient/":
      ensure => directory,
      owner  => $dataverse::dataverse::glassfish_user;
    "${dataverse::dataverse::home}/modules/weld-osgi-bundle.jar":
      ensure => present,
      owner  => $dataverse::dataverse::glassfish_user,
      source => 'puppet:///modules/dataverse/weld-osgi-bundle-patch.jar';
    "${dataverse::dataverse::home}/modules/glassfish-grizzly-extra-all.jar":
      ensure => present,
      owner  => $dataverse::dataverse::glassfish_user,
      source => 'puppet:///modules/dataverse/glassfish-grizzly-extra-all.jar';
    "${dataverse::dataverse::domain}/config/jhove.conf":
      ensure => present,
      owner  => $dataverse::dataverse::glassfish_user,
      source => "puppet:///modules/dataverse/${dataverse::dataverse::_package}/conf/jhove/jhove.conf";
    "${dataverse::dataverse::home}/lib/${pgdriver}":
      ensure           => present,
      owner            => $dataverse::dataverse::glassfish_user,
      source           => "puppet:///modules/dataverse/pgdriver/$pgdriver";
    '/var/log/glassfish':
      ensure => link,
      target => "${dataverse::dataverse::domain}/logs";
  }

  exec {
    'Create the files directory': # We use an exec rather than a file type, because the path may have subdirectories.
      require          => Class['glassfish'],
      command          => "/bin/mkdir -p ${dataverse::dataverse::files_directory} && chown -R ${dataverse::dataverse::glassfish_user}:${dataverse::dataverse::glassfish_user} ${dataverse::dataverse::files_directory}",
      creates          => $dataverse::dataverse::files_directory;
  }

}