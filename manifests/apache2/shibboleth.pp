# Shibboleth is not part of this puppet module until it's experimental status is changed to production ready.
# We therefore only install the packages.
class iqss::apache2::shibboleth {

  notify {
    'Shibboleth status experimental':
      message => 'Shibboleth support in Dataverse should be considered experimental until the following issue is closed: https://github.com/IQSS/dataverse/issues/2117
In Dataverse 4.0, Shibboleth support requires fronting Glassfish with Apache as described below, but this configuration has not been heavily tested in a production environment and is not recommended until this issue is closed: https://github.com/IQSS/dataverse/issues/2180',
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
    path => $iqss::params::shibboleth_lib,
  }

}

