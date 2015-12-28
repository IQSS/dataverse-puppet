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
      ensure     => present,
      uid        => $dataverse::rserve::uid,
      groups     => $dataverse::rserve::rserve_user,
      home       => "/home/${dataverse::rserve::rserve_user}",
      managehome => true,
  }
  group {
    $dataverse::rserve::rserve_user:
      ensure => present,
      gid    => $dataverse::rserve::gid,
  }

  file {
    '/etc/Rserv.conf':
      ensure  => present,
      content => template( 'dataverse/rserve/Rserve.conf.erb' ),
      group   => $dataverse::rserve::rserve_user,
      notify  => Service['rserve'] ,
      owner   => $dataverse::rserve::rserve_user ;
    '/etc/Rserv.pwd':
      ensure  => present,
      content => "${dataverse::rserve::rserve_user} ${dataverse::rserve::password}",
      group   => $dataverse::rserve::rserve_user,
      mode    => '0400',
      notify  => Service['rserve'] ,
      owner   => $dataverse::rserve::rserve_user ;
    '/var/log/rserve/':
      ensure => directory,
      group  => $dataverse::rserve::rserve_user,
      owner  => $dataverse::rserve::rserve_user ;
    '/etc/init.d/rserve':
      ensure  => present,
      content => template( 'dataverse/rserve/rserve-startup.sh' ) ,
      mode    => '0755';
  }

  service {
    'rserve':
      ensure     => running,
      enable     => true,
      path       => '/etc/init.d/',
      hasrestart => true ;
  }

}