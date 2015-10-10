# = Puppet module for dataverse.
# == Class: Iqss::Solr::Service
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
class iqss::solr::service {
  anchor { 'iqss::solr::service::begin': }->
  service { 'solr':
    ensure     => running,
    enable     => true,
    path       => '/etc/init.d/',
    hasrestart => true,
    subscribe  => File["${iqss::solr::solr_home}/${iqss::solr::core}/conf"]
  }

  anchor { 'solr::service::end':
    require => Service ['solr'],
  }

}