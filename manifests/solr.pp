# = Puppet module for dataverse.
# == Class: dataverse::solr
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
# === Examples
#
#   class { dataverse:solr
#     parent_dir => '/usr/share',
#   }
#

class dataverse::solr (
  $core               = $dataverse::params::solr_core,
  $jetty_home         = $dataverse::params::solr_jetty_home,
  $jetty_host         = $dataverse::params::solr_jetty_host,
  $jetty_java_options = $dataverse::params::solr_jetty_java_options,
  $jetty_port         = $dataverse::params::solr_jetty_port,
  $jetty_user         = $dataverse::params::solr_jetty_user,
  $parent_dir         = $dataverse::params::solr_parent_dir,
  $solr_home          = $dataverse::params::solr_solr_home,
  $url                = $dataverse::params::solr_url,
  $version            = $dataverse::params::solr_version,
) inherits dataverse::params {

  $dataverse_package = $dataverse::params::dataverse_package

  anchor{ 'dataverse::solr::begin': }

  class{ 'dataverse::solr::install':
    require => Anchor['dataverse::solr::begin'],
  }

  class{ 'dataverse::solr::config':
    require => Class['dataverse::solr::install'],
  }

  class{ 'dataverse::solr::service':
    subscribe => Class['dataverse::solr::config'],
  }

  anchor{ 'dataverse::solr::end':
    require => Class['dataverse::solr::service'],
  }
}