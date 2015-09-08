# Private class. Do not use directly

#####`apache_default_vhost`

#Sets a given `apache::vhost` as the default to serve requests that do not match any other `apache::vhost` definitions. The default value is 'false'.

#####`apache_default_ssl_vhost`

#Sets up a default SSL virtual host. Defaults to 'false'.

#####`apache_default_mods`

#Installs default Apache modules based on what OS you are running. Defaults to 'false'.

#####`apache_default_confd_files`

#Generates default set of include-able Apache configuration files under  `${apache::confd_dir}` directory. These configuration files correspond to what is usually installed with the Apache package on a given platform.

class iqss::apache2 (
  $default_confd_files = $iqss::params::apache2_default_confd_files,
  $default_mods        = $iqss::params::apache2_default_mods,
  $default_ssl_vhost   = $iqss::params::apache2_default_ssl_vhost,
  $default_vhost       = $iqss::params::apache2_default_vhost,
  $purge_configs       = $iqss::params::apache2_purge_configs,
) inherits iqss::params {

  anchor { 'iqss::apache2::start': }->
  class { 'iqss::apache2::install': }->
  class { 'iqss::apache2::shibboleth': }->
  anchor { 'iqss::apache2::end': }

}