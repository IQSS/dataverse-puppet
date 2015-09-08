class iqss::apache2::install {

  class { 'apache':
    default_confd_files          => $iqss::apache2::default_confd_files,
    default_mods                 => $iqss::apache2::default_mods,
    default_ssl_vhost            => $iqss::apache2::default_ssl_vhost,
    default_vhost                => $iqss::apache2::default_vhost,
    purge_configs                => $iqss::apache2::purge_configs,
  }

  class {
    $iqss::params::apache_mods:
  }


}

