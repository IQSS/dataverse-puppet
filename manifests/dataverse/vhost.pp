# = Puppet module for dataverse.
# == Class: Iqss::Dataverse::Vhost
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

class iqss::dataverse::vhost {

  if ! defined(Class['iqss::apache2']) {
    class {
      'iqss::apache2':
    }
  }

  file {
    '/opt/dataverse/dataverse.conf':
      ensure   => file,
      source   => "puppet:///modules/iqss/${iqss::dataverse::_package}/conf/httpd/conf.d/dataverse.conf",
      notify   => Service[$::apache::service_name];
  }

# Depending on the OS:
  case $::osfamily {
    'redhat': {
      file {
        "${::apache::confd_dir}/dataverse.conf":
          ensure   => file,
          content  => template('iqss/dataverse/dataverse.conf.erb'),
          notify   => Service[$::apache::service_name];
      }
    }
    'debian': {
      file {
         "${::apache::vhost_dir}/dataverse.conf":
          ensure   => file,
          content  => template('iqss/dataverse/dataverse.conf.erb'),
          notify   => Service[$::apache::service_name];
        "${::apache::vhost_enable_dir}/25-dataverse.conf":
          ensure => link,
          target => "${::apache::vhost_dir}/dataverse.conf";
      }
    }
  }


}
