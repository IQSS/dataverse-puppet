# = Puppet module for dataverse.
# == Class: Dataverse::Solr::Service
#
# === Copyright
#
# Puppet module for dataverse.
# GPLv3 - Copyright (C) 2015 International Institute of Social History <socialhistory.org>.
#
# === Description
#
# === Copyright
#
# Puppet module for dataverse.
# GPLv3 - Copyright (C) 2015 International Institute of Social History <socialhistory.org>.
#
# Private class. Do not use directly.
#
class dataverse::solr::service {
  anchor { 'dataverse::solr::service::begin': }->
  service { $dataverse::solr::jetty_user:
    ensure     => running,
    enable     => true,
    path       => '/etc/init.d/',
    hasrestart => true,
    subscribe  => File["${dataverse::solr::solr_home}/${dataverse::solr::core}/conf"]
  }

  anchor { 'solr::service::end':
    require => Service[$dataverse::solr::jetty_user],
  }

}