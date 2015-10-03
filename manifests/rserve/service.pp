# Set the user and configuration for rserve
class iqss::rserve::service {

  user {
    $iqss::params::rserve_user:
      ensure => present,
      uid    => $iqss::rserve::uid,
      groups => $iqss::params::rserve_user,
  }
  group {
    $iqss::params::rserve_user:
      ensure => present,
      gid    => $iqss::rserve::gid,
  }

  file {
    '/etc/Rserv.conf':
      ensure  => present,
      owner   => $iqss::params::rserve_user,
      group   => $iqss::params::rserve_user,
      content => template( 'iqss/rserve/Rserve.conf.erb' ),
      notify  => Service['rserve'] ;
    '/etc/Rserv.pwd':
      ensure  => present,
      owner   => $iqss::params::rserve_user,
      group   => $iqss::params::rserve_user,
      content => "${iqss::params::rserve_user} ${iqss::rserve::pwd}",
      notify  => Service['rserve'] ;
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
      hasrestart => true ;
  }

}