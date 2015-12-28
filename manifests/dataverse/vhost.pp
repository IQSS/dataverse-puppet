# = Puppet module for dataverse.
# == Class: Dataverse::Dataverse::Vhost
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
# Add the Apache virtual host to direct HTTP traffic to the ajp listener.

class dataverse::dataverse::vhost {

  if ! defined(Class['dataverse::apache2']) {
    class {
      'dataverse::apache2':
    }
  }

  file {
    '/opt/dataverse/dataverse.conf':
      ensure   => file,
      source   => "puppet:///modules/dataverse/${dataverse::dataverse::_package}/conf/httpd/conf.d/dataverse.conf",
      notify   => Service[$::apache::service_name];
  }

# Depending on the OS:
  case $::osfamily {
    'redhat': {
      file {
        "${::apache::confd_dir}/dataverse.conf":
          ensure   => file,
          content  => template('dataverse/dataverse/dataverse.conf.erb'),
          notify   => Service[$::apache::service_name];
      }
    }
    'debian': {
      file {
        "${::apache::vhost_dir}/dataverse.conf":
          ensure   => file,
          content  => template('dataverse/dataverse/dataverse.conf.erb'),
          notify   => Service[$::apache::service_name];
        "${::apache::vhost_enable_dir}/25-dataverse.conf":
          ensure => link,
          target => "${::apache::vhost_dir}/dataverse.conf";
      }
    }
    default: {
      fail("OSFamily ${::osfamily} is not currently supported.")
    }
  }


}
