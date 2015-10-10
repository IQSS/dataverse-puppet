# = Puppet module for dataverse.
# == Class: Iqss::Dataverse
#
# === Copyright
#
# Puppet module for dataverse.
# GPLv3 - Copyright (C) 2015 International Institute of Social History <socialhistory.org>.
#
# === Description
#
# This installs a Dataverse server.
# By default we will  install glassfish in /home/glassfish like described in:
# https://glassfish.java.net/docs/4.0/installation-guide.pdf
#
# === Parameters
#


class iqss::dataverse (
  $auth_password_reset_timeout_in_minutes = $iqss::params::dataverse_auth_password_reset_timeout_in_minutes,
  $doi_baseurlstring                      = $iqss::params::doi_baseurlstring,
  $doi_username                           = $iqss::params::doi_username,
  $doi_password                           = $iqss::params::doi_password,
  $files_directory                        = $iqss::params::dataverse_files_directory,
  $glassfish_create_domain                = $iqss::params::glassfish_create_domain,
  $glassfish_domain_name                  = $iqss::params::glassfish_domain_name,
  $glassfish_fromaddress                  = $iqss::params::glassfish_fromaddress,
  $glassfish_jvmoption                    = $iqss::params::glassfish_jvmoption,
  $glassfish_mailhost                     = $iqss::params::glassfish_mailhost,
  $glassfish_mailuser                     = $iqss::params::glassfish_mailuser,
  $glassfish_mailproperties               = $iqss::params::glassfish_mailproperties,
  $glassfish_parent_dir                   = $iqss::params::glassfish_parent_dir,
  $glassfish_remove_default_domain        = $iqss::params::glassfish_remove_default_domain,
  $glassfish_service_name                 = $iqss::params::glassfish_service_name,
  $glassfish_tmp_dir                      = $iqss::params::glassfish_tmp_dir,
  $glassfish_user                         = $iqss::params::glassfish_user,
  $glassfish_version                      = $iqss::params::glassfish_version,
  $package                                = $iqss::params::dataverse_package,
  $port                                   = $iqss::params::dataverse_port,
  $repository                             = $iqss::params::dataverse_repository,
  $rserve_host                            = $iqss::params::dataverse_rserve_host,
  $rserve_password                        = $iqss::params::dataverse_rserve_password,
  $rserve_port                            = $iqss::params::dataverse_rserve_port,
  $rserve_user                            = $iqss::params::dataverse_rserve_user,
  $site_url                               = $iqss::params::dataverse_site_url,

) inherits iqss::params {

  $home   = "${iqss::dataverse::glassfish_parent_dir}/glassfish-${iqss::dataverse::glassfish_version}/glassfish"
  $domain = "${home}/domains/${iqss::dataverse::glassfish_domain_name}"

  anchor { 'iqss::dataverse::start': }->
  class { 'iqss::dataverse::install': }->
  class { 'iqss::dataverse::reload': }->
  class { 'iqss::dataverse::war': }->
  class { 'iqss::dataverse::deploy': }->
  class { 'iqss::dataverse::vhost': }->
  anchor { 'iqss::dataverse::end': }


}