# = Puppet module for dataverse.
# == Class: Iqss::Rpackager
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
# Installs R, required libraries and then a range of packages used by dataverse (RServe) and TwoRavens (Rook, Zelig, and
# others).
#
# === Parameters
#
# [repo='http://cran.r-project.org'|mirror]
#   The repository to download the packages from.
#
# [packages]
#   A list of R packages to install.
#
# [packages_zelig='https://github.com/IQSS/Zelig/archive/master.zip']
#   The url to the Zelig package.
#
# === Variables
#
# [r_site_library]
#   The library folder for installed R packages.
#
# [rpackager_rstudio_libraries]
#   A list of R library dependencies to install.
#
class iqss::rpackager (
  $repo              = $iqss::params::rpackager_repo,
  $packages          = $iqss::params::rpackager_packages,
  $packages_zelig    = $iqss::params::rpackager_packages_zelig,
) inherits iqss::params {

  $r_site_library = $iqss::params::rpackager_r_site_library
  $rstudio_libraries = $iqss::params::rpackager_rstudio_libraries

  anchor { 'iqss::rpackager::start': }->
  class { 'iqss::rpackager::repo': }->
  class { 'iqss::rpackager::install': }->
  class { 'iqss::rpackager::packages': }->
  anchor { 'iqss::rpackager::end': }

}