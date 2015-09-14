# Private class. Do not use directly.
# Installs R, required libraries and then a range of packages used by dataverse (RServe) and TwoRavens (Rook, Zelig, etc.).
class iqss::rpackager (
  $repo              = $iqss::params::rpackager_repo,
  $packages          = $iqss::params::rpackager_packages,
  $packages_zelig    = $iqss::params::rpackager_packages_zelig,
) inherits iqss::params {

  anchor { 'iqss::rpackager::start': }->
  class { 'iqss::rpackager::repo': }->
  class { 'iqss::rpackager::install': }->
  class { 'iqss::rpackager::packages': }->
  anchor { 'iqss::rpackager::end': }

}