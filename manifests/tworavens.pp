# = Puppet module for dataverse.
# == Class: iqss::tworavens
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
# [domain='localhost']
#   The public domain name of the TwoRavens web application. Defaults to 'localhost'.
#
# [package='https://github.com/IQSS/TwoRavens/archive/v0.1.zip']
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
# [rapache_version='1.2.6']
#   The rapache version to be installed.
#
# === Examples
#
#   class { iqss:tworavens
#     domain => 'analysis.domain.org',
#   }
#
class iqss::tworavens (
  $dataverse_fqdn           = $iqss::params::dataverse_fqdn,
  $dataverse_port           = $iqss::params::dataverse_port,
  $domain                   = $iqss::params::tworavens_domain,
  $package                  = $iqss::params::tworavens_package, # Do not end this value with a slash
  $parent_dir               = $iqss::params::tworavens_parent_dir, # Do not end this value with a slash
  $port                     = $iqss::params::tworavens_port,
  $protocol                 = $iqss::params::tworavens_protocol,
  $rapache_version          = $iqss::params::tworavens_rapache_version
) inherits iqss::params {

  $dataexplore_dir = "${parent_dir}/dataexplore"

  anchor { 'iqss::tworavens::start': }->
  class { 'iqss::tworavens::install': }->
  class { 'iqss::tworavens::config': }->
  anchor { 'iqss::tworavens::end': }

}