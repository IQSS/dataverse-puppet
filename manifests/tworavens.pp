class iqss::tworavens (
  $domain                   = $iqss::params::tworavens_domain,
  $package                  = $iqss::params::tworavens_package, # Do not end this value with a slash
  $parent_dir               = $iqss::params::tworavens_parent_dir, # Do not end this value with a slash
  $port                     = $iqss::params::tworavens_port,
  $protocol                 = $iqss::params::tworavens_protocol,
  $rapache_version          = $iqss::params::tworavens_rapache_version,
  $dataverse_fqdn           = $iqss::params::dataverse_fqdn,
  $dataverse_port           = $iqss::params::dataverse_port,
  $dataverse_site_url       = $iqss::params::dataverse_site_url ,
) inherits iqss::params {

  $dataexplore_dir = "${parent_dir}/dataexplore"

  anchor { 'iqss::tworavens::start': }->
  class { 'iqss::tworavens::install': }->
  class { 'iqss::tworavens::config': }->
  anchor { 'iqss::tworavens::end': }

}