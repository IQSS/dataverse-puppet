# = Puppet module for dataverse.
# == Class: dataverse::tworavens
#
# === Copyright
#
# Puppet module for dataverse.
# GPLv3 - Copyright (C) 2015 International Institute of Social History <socialhistory.org>.
#
# === Description
#
# Installs TwoRavens.
# Also see: http://github.com/iqss/tworavens
#
# === Parameters
#
# [dataverse_fqdn='localhost']
#   The public domain name of the Dataverse web application.
#
# [dataverse_port=443]
# The public port of the Dataverse web application.
#
# [fqdn='localhost']
#   The public domain name of the TwoRavens web application. Defaults to 'localhost'.
#
# [package='https://github.com/IQSS/TwoRavens/archive/master.zip']
#   The download url of the TwoRavens web application.
#
# [parent_dir='/var/www/html'].
#   The installation directory of the TwoRavens web application.
#
# [port=443]
#   The public port of the TwoRavens web application.
#
# [protocol='https|http]
#   The protocol of the TwoRavens web application.
#
# === Variables
#
# [dataexplore_dir='/var/www/html/dataexplore']
#   The target for the installation
#
# [mod_r_so_file]
#   The binary so file that is the rapache library.
#
# [rapache_version='1.2.6']
#   The rapache version to be installed.
#
# === Examples
#
#   class { dataverse:tworavens
#     fqdn => 'analysis.domain.org',
#   }

class dataverse::tworavens (
  $dataverse_fqdn           = $dataverse::params::dataverse_fqdn,
  $dataverse_port           = $dataverse::params::dataverse_port,
  $fqdn                     = $dataverse::params::tworavens_fqdn,
  $package                  = $dataverse::params::tworavens_package, # Do not end this value with a slash
  $parent_dir               = $dataverse::params::tworavens_parent_dir, # Do not end this value with a slash
  $port                     = $dataverse::params::tworavens_port,
  $protocol                 = $dataverse::params::tworavens_protocol,
) inherits dataverse::params {

  $dataexplore_dir = "${parent_dir}/dataexplore"
  $mod_r_so_file = $dataverse::params::tworavens_mod_r_so_file
  $rapache_version          = $dataverse::params::tworavens_rapache_version


  anchor { 'dataverse::tworavens::start': }->
  class { 'dataverse::tworavens::install': }->
  class { 'dataverse::tworavens::config': }->
  anchor { 'dataverse::tworavens::end': }

}