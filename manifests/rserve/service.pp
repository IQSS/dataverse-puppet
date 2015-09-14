# Set the user and configuration for rserve
class iqss::rserve::service {

  $group_and_user_id = 97

  user {
    $iqss::params::rserve_user:
      ensure => present,
      uid    => $group_and_user_id,
      groups => $iqss::params::rserve_user,
  }
  group {
    $iqss::params::rserve_user:
      ensure => present,
      gid    => $group_and_user_id,
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