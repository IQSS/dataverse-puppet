class iqss::database (
  $createdb                = $iqss::params::database_createdb,
  $createrole              = $iqss::params::database_createrole,
  $encoding                = $iqss::params::database_encoding,
  $version                 = $iqss::params::database_version,
  $hba_rule                = $iqss::params::database_hba_rule,
  $locale                  = $iqss::params::database_locale,
  $login                   = $iqss::params::database_login,
  $manage_package_repo     = $iqss::params::database_manage_package_repo,
  $port                    = $iqss::params::database_port,
  $replication             = $iqss::params::database_replication,
  $listen_addresses        = $iqss::params::database_listen_addresses,
  $superuser               = $iqss::params::database_superuser,
) inherits iqss::params {

  anchor { 'iqss::database::start': }->
  class { 'iqss::database::install': }->
  class { 'iqss::database::config': }->
  anchor { 'iqss::database::end': }

}