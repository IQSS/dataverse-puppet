# = Puppet module for dataverse.
# == Class: Iqss::Rserve::Service
#
# === Copyright
#
# Puppet module for dataverse.
# GPLv3 - Copyright (C) 2015 International Institute of Social History <socialhistory.org>.
#
# === Description
#
# Private class. Do not use directly.
#
# Set the user and configuration for the rserve daemon
#
class iqss::rserve::service {

  user {
    $iqss::rserve::rserve_user:
      ensure => present,
      uid    => $iqss::rserve::uid,
      groups => $iqss::rserve::rserve_user,
  }
  group {
    $iqss::rserve::rserve_user:
      ensure => present,
      gid    => $iqss::rserve::gid,
  }

  file {
    '/etc/Rserv.conf':
      content => template( 'iqss/rserve/Rserve.conf.erb' ),
      ensure  => present,
      group   => $iqss::rserve::rserve_user,
      notify  => Service['rserve'] ,
      owner   => $iqss::rserve::rserve_user ;
    '/etc/Rserv.pwd':
      content => "${iqss::rserve::rserve_user} ${iqss::rserve::password}",
      ensure  => present,
      group   => $iqss::rserve::rserve_user,
      mode    => 400,
      notify  => Service['rserve'] ,
      owner   => $iqss::rserve::rserve_user ;
    '/var/log/rserve/':
      ensure => directory,
      group  => $iqss::rserve::rserve_user,
      owner  => $iqss::rserve::rserve_user ;
    '/etc/init.d/rserve':
      ensure  => present,
      content => template( 'iqss/rserve/rserve-startup.sh.erb' ) ,
      mode    => 755;
  }

  service {
    'rserve':
      ensure     => running,
      enable     => true,
      path       => '/etc/init.d/',
      hasrestart => true ;
  }

}