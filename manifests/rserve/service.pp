# = Puppet module for dataverse.
# == Class: Dataverse::Rserve::Service
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
class dataverse::rserve::service {

  user {
    $dataverse::rserve::rserve_user:
      ensure => present,
      uid    => $dataverse::rserve::uid,
      groups => $dataverse::rserve::rserve_user,
  }
  group {
    $dataverse::rserve::rserve_user:
      ensure => present,
      gid    => $dataverse::rserve::gid,
  }

  file {
    '/etc/Rserv.conf':
      content => template( 'dataverse/rserve/Rserve.conf.erb' ),
      ensure  => present,
      group   => $dataverse::rserve::rserve_user,
      notify  => Service['rserve'] ,
      owner   => $dataverse::rserve::rserve_user ;
    '/etc/Rserv.pwd':
      content => "${dataverse::rserve::rserve_user} ${dataverse::rserve::password}",
      ensure  => present,
      group   => $dataverse::rserve::rserve_user,
      mode    => 400,
      notify  => Service['rserve'] ,
      owner   => $dataverse::rserve::rserve_user ;
    '/var/log/rserve/':
      ensure => directory,
      group  => $dataverse::rserve::rserve_user,
      owner  => $dataverse::rserve::rserve_user ;
    '/etc/init.d/rserve':
      ensure  => present,
      content => template( 'dataverse/rserve/rserve-startup.sh.erb' ) ,
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