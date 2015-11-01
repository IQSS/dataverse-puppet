# = Puppet module for dataverse.
# == Class: iqss::solr
#
# === Copyright
#
# Puppet module for dataverse.
# GPLv3 - Copyright (C) 2015 International Institute of Social History <socialhistory.org>.
#
# === Description
#
# Installs Solr together with the dataverse schema.
# Also see: http://lucene.apache.org/solr
#
# === Parameters
#
# [core='collection1']
#   The handle of the Solr core.
#
# [jetty_home='/home/solr/solr-4.6.0/example']
#   The Jetty home directory which contains start.jar.
#
# [jetty_host='0.0.0.0']
#   The IP to listen to.
#
# [jetty_java_options='-Xmx512m']
#   JVM options for the Jetty container.
#
# [jetty_port=8983]
#    The port Jetty will listen to.
#
# [jetty_user='solr']
#   The user running the Jetty Solr instance.
#
# [solr_home='/home/solr/solr-4.6.0/example/solr']
#   The Solr home used for the jvm setting -Dsolr.solr.home.
#
# [url='http://archive.apache.org/dist/lucene/solr']
#   The download url for solr. Preferably a mirror.
#
# === Variables
#
# [dataverse_package]
#   The package name and version of dataverse.
#
# [required_packages]
#   Solr dependencies ( java ) that must be installed.
#
# === Examples
#
#   class { iqss:solr
#     parent_dir => '/usr/share',
#   }
#

class iqss::solr (
  $core               = $iqss::params::solr_core,
  $jetty_home         = $iqss::params::solr_jetty_home,
  $jetty_host         = $iqss::params::solr_jetty_host,
  $jetty_java_options = $iqss::params::solr_jetty_java_options,
  $jetty_port         = $iqss::params::solr_jetty_port,
  $jetty_user         = $iqss::params::solr_jetty_user,
  $parent_dir         = $iqss::params::solr_parent_dir,
  $solr_home          = $iqss::params::solr_solr_home,
  $url                = $iqss::params::solr_url,
  $version            = $iqss::params::solr_version,
) inherits iqss::params {

  $dataverse_package = $iqss::params::dataverse_package
  $required_packages = $iqss::params::solr_required_packages

  anchor{ 'iqss::solr::begin': }

  #if ! defined(Packages[$required_packages]) {
  #  package {
  #    $required_packages:
  #      ensure => installed,
  #  }
  #}

  class{ 'iqss::solr::install':
    require => Anchor['iqss::solr::begin'],
  }

  class{ 'iqss::solr::config':
    require => Class['iqss::solr::install'],
  }

  class{ 'iqss::solr::service':
    subscribe => Class['iqss::solr::config'],
  }

  anchor{ 'iqss::solr::end':
    require => Class['iqss::solr::service'],
  }
}