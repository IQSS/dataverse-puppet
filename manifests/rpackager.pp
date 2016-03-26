# = Puppet module for dataverse.
# == Class: Dataverse::Rpackager
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
# [packages]
#   A list of R packages to install.
#
# === Variables
#
# [contriburl='https://cran.r-project.org/src/contrib/Archive/']
#   The url to the custom R packages.
#
# [r_path='/usr/bin/R']
#   The location of the R binary.
#
# [r_repos='https://cran.r-project.org/']
#   The R package repository.
#
# [r_site_library]
#   The library folder for installed R packages.
#
# [rpackager_rstudio_libraries]
#   A list of R library dependencies to install.

class dataverse::rpackager (
) inherits dataverse::params {

  $contriburl        = $dataverse::params::contriburl
  $r_path            = $dataverse::params::r_path
  $r_repos           = $dataverse::params::r_repos
  $r_site_library    = $dataverse::params::rpackager_r_site_library
  $rstudio_libraries = $dataverse::params::rpackager_rstudio_libraries

  anchor { 'dataverse::rpackager::start': }->
  class { 'dataverse::rpackager::repo': }->
  class { 'dataverse::rpackager::install': }->
  anchor { 'dataverse::rpackager::end': }

}