# This installs a Dataverse server. See README.md for more details.

class iqss::dataverse (
  $ensure                                           = $iqss::params::ensure,
  $dataverse_auth_password_reset_timeout_in_minutes = $iqss::params::dataverse_auth_password_reset_timeout_in_minutes,
  $dataverse_files_directory                        = $iqss::params::dataverse_files_directory,
  $dataverse_rserve_host                            = $iqss::params::dataverse_rserve_host,
  $dataverse_rserve_password                        = $iqss::params::dataverse_rserve_password,
  $dataverse_rserve_port                            = $iqss::params::dataverse_rserve_port,
  $dataverse_rserve_user                            = $iqss::params::dataverse_rserve_user,
  $dataverse_site_url                               = $iqss::params::dataverse_site_url,
  $doi_baseurlstring                                = $iqss::params::doi_baseurlstring,
  $doi_username                                     = $iqss::params::doi_username,
  $doi_password                                     = $iqss::params::doi_password,
  $glassfish_create_domain                          = $iqss::params::glassfish_create_domain,
  $glassfish_domain_name                            = $iqss::params::glassfish_domain_name,
  $glassfish_fromaddress                            = $iqss::params::glassfish_fromaddress,
  $glassfish_jvmoption                              = $iqss::params::glassfish_jvmoption,
  $glassfish_mailhost                               = $iqss::params::glassfish_mailhost,
  $glassfish_mailuser                               = $iqss::params::glassfish_mailuser,
  $glassfish_mailproperties                         = $iqss::params::glassfish_mailproperties,
  $glassfish_parent_dir                             = $iqss::params::glassfish_parent_dir,
  $glassfish_remove_default_domain                  = $iqss::params::glassfish_remove_default_domain,
  $glassfish_service_name                           = $iqss::params::glassfish_service_name,
  $glassfish_tmp_dir                                = $iqss::params::glassfish_tmp_dir,
  $glassfish_user                                   = $iqss::params::glassfish_user,
  $glassfish_version                                = $iqss::params::glassfish_version,
  $repository                                       = $iqss::params::repository,
  $trigger                                          = $iqss::params::trigger,

) inherits iqss::params {

  anchor { 'iqss::dataverse::start': }->
  class { 'iqss::dataverse::install': }->
  class { 'iqss::dataverse::config': }->
  class { 'iqss::dataverse::war': }->
  class { 'iqss::dataverse::deploy': }->
  class { 'iqss::dataverse::vhost': }->
  anchor { 'iqss::dataverse::end': }


}