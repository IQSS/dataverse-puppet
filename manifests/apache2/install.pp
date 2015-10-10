# = Puppet module for dataverse.
# == Class: Iqss::Apache2::Install
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
# Installs apache and the required mods.
#
class iqss::apache2::install {

  class { 'apache':
    default_confd_files          => $iqss::apache2::default_confd_files,
    default_mods                 => $iqss::apache2::default_mods,
    default_ssl_vhost            => $iqss::apache2::default_ssl_vhost,
    default_vhost                => $iqss::apache2::default_vhost,
    purge_configs                => $iqss::apache2::purge_configs,
  }

  class {
    $iqss::params::apache_mods:
  }


}

