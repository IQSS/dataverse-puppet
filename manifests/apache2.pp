# = Puppet module for dataverse.
# == Class: Dataverse::Apache2
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
# Installs apache.
#
# === Parameters
#
# [purge_configs=true|false]
#   Removes all other Apache configs and vhosts. Setting this to 'false' is a stopgap measure to allow the apache module
#   to coexist with existing or otherwise-managed configuration.
#
# === Variables
#
# [default_confd_files=false|true]
#   Generates default set of include-able Apache configuration files under `${apache::confd_dir}` directory. These
#   configuration files correspond to what is usually installed with the Apache package on a given platform.
#
# [default_mods=false|true]
#   Installs default Apache modules based on what OS you are running.
#
# [default_ssl_vhost=false|true]
#   Sets up a default SSL virtual host.
#
# [default_vhost=false|true]
#   Sets a given `apache::vhost` as the default to serve requests that do not match any other `apache::vhost`
#   definitions.
#
# [mods]
#   A list of apache modules to install.

class dataverse::apache2 (
  $purge_configs          = $dataverse::params::apache2_purge_configs,
) inherits dataverse::params {

  $shibboleth_lib         = $dataverse::params::apache2_shibboleth_lib
  $default_confd_files    = $dataverse::params::apache2_default_confd_files
  $default_mods           = $dataverse::params::apache2_default_mods
  $default_ssl_vhost      = $dataverse::params::apache2_default_ssl_vhost
  $default_vhost          = $dataverse::params::apache2_default_vhost
  $mods                   = $dataverse::params::apache2_mods

  anchor { 'dataverse::apache2::start': }->
  class { 'dataverse::apache2::install': }->
  class { 'dataverse::apache2::shibboleth': }->
  anchor { 'dataverse::apache2::end': }

}