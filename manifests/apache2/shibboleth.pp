# = Puppet module for dataverse.
# == Class: Dataverse::Apache2::Shibboleth
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
# Shibboleth is not part of this puppet module until it's experimental status is changed to production ready.
# We therefore only install the packages.

class dataverse::apache2::shibboleth {

  notify {
    'Shibboleth status experimental':
      message => 'Shibboleth support in Dataverse should be considered experimental until the following issue is closed: https://github.com/IQSS/dataverse/issues/2117',
  }

  include shibboleth::params

  shibboleth::repos { 'default': }

  if $::osfamily == 'RedHat' {
    package {
      $shibboleth::params::shib_package_name: # Defined in the shibboleth module
        ensure  => installed,
        require => Exec['Add yum repository'],
        notify => Apache::Mod['shib2'],
    }
  }

  if $::osfamily == 'Debian' {
    package { $shibboleth::params::mod_ssl_package_name: # Defined in the shibboleth module
      ensure => installed,
      notify => Apache::Mod['shib2'],
    }
  }

  apache::mod { 'shib2':
    id   => 'mod_shib',
    path => $dataverse::apache2::shibboleth_lib,
  }

}

