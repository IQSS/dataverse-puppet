# Install the shared settings and base libraries.
class iqss::globals (
  $apache2_default_vhost       = false,
  $apache2_default_ssl_vhost   = false,
  $apache2_default_mods        = false,
  $apache2_default_confd_files = false,
  $apache2_purge_configs       = true,
  $dataverse_fqdn              = 'localhost',
  $dataverse_port              = 443,
  $database_host               = 'localhost',
  $database_name               = 'dvndb',
  $database_password           = 'dvnAppPass',
  $database_port               = '5432',
  $database_user               = 'dvnApp',
  $ensure                      = 'present',
  $rserve_pwd                  = 'rserve'
) {
  package {
    ['unzip']:
      ensure => installed,
  }
}