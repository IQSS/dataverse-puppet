# Install the rserve service and the schema for Dataverse.
class iqss::rserve::service {

  user {
    $iqss::params::rserve_user:
      ensure => present,
      groups => $iqss::params::rserve_user,
  }
  group {
    $iqss::params::rserve_user:
      ensure => present,
  }

  file {
    '/etc/Rserv.conf':
      ensure => present,
      owner  => $iqss::params::rserve_user,
      group  => $iqss::params::rserve_user,
      source => 'puppet:///modules/iqss/dataverse/conf/R/Rserv.conf';
    '/etc/Rserv.pwd':
      ensure => present,
      owner  => $iqss::params::rserve_user,
      group  => $iqss::params::rserve_user,
      source => 'puppet:///modules/iqss/dataverse/conf/R/Rserv.pwd';
    '/var/log/rserve/':
      ensure => directory,
      owner  => $iqss::params::rserve_user,
      group  => $iqss::params::rserve_user;
    '/etc/init.d/rserve':
      ensure  => present,
      mode    => 755,
      content => template( 'iqss/rserve/rserve-startup.sh.erb' );
  }

  service {
    'rserve':
      ensure     => running,
      enable     => true,
      path       => '/etc/init.d/',
      hasrestart => true,
      require    => File['/etc/init.d/rserve', '/var/log/rserve/'],
      subscribe  => File['/etc/Rserv.conf', '/etc/Rserv.pwd']
  }

}