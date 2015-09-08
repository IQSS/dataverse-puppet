class iqss::solr (
  $url                = $iqss::params::solr_url,
  $version            = $iqss::params::solr_version,
  $solr_parent_dir    = $iqss::params::solr_solr_parent_dir,
  $jetty_user         = $iqss::params::solr_jetty_user,
  $jetty_host         = $iqss::params::solr_jetty_host,
  $jetty_port         = $iqss::params::solr_jetty_port,
  $jetty_java_options = $iqss::params::solr_jetty_java_options,
  $jetty_home         = $iqss::params::solr_jetty_home,
  $solr_home          = $iqss::params::solr_solr_home,
  $core               = $iqss::params::solr_core,
) inherits iqss::params {

## === Variables === ##
  anchor{ 'iqss::solr::begin': }

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