# == Class: iqss::solr::service
#
# === Parameters
#
#
# === Variables
#
# === Examples
#
#
# === Copyright
#
# GPL-3.0+
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