# Private class. Do not use directly
class iqss::rserve (
  $package_repo   = $iqss::params::rserve_package_repo,
  $packages_r     = $iqss::params::rserve_packages_r,
  $packages_zelig = $iqss::params::rserve_packages_zelig,
) inherits iqss::params {

  anchor { 'iqss::rserve::start': }->
  class { 'iqss::rserve::repo': }->
  class { 'iqss::rserve::install': }->
  class { 'iqss::rserve::packages': }->
  class { 'iqss::rserve::service': }->
  anchor { 'iqss::rserve::end': }

}