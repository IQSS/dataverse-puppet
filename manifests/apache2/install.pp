# = Puppet module for dataverse.
# == Class: Dataverse::Apache2::Install
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

class dataverse::apache2::install {

  class { 'apache':
    default_confd_files => $dataverse::apache2::default_confd_files,
    default_mods        => $dataverse::apache2::default_mods,
    default_ssl_vhost   => $dataverse::apache2::default_ssl_vhost,
    default_vhost       => $dataverse::apache2::default_vhost,
    purge_configs       => $dataverse::apache2::purge_configs,
  }

  class {
    $dataverse::apache2::mods:
  }


}

