# = Puppet module for dataverse.
# == Class: iqss::rserve
#
# === Copyright
#
# Puppet module for dataverse.
# GPLv3 - Copyright (C) 2015 International Institute of Social History <socialhistory.org>.
#
# === Description
#
# Installs the RServe package with a Binary R server (a daemon) together with a range of R packages.
# Also see: https://rforge.net/Rserve/doc.html
#
# === Parameters
#
# [auth='required'|'disable']
#   If you need remote access use set auth 'required' and plaintext to 'disable'.
#
# [chroot=undef]
#   The path to the jail directory.
#
# [encoding='utf-8'|native|latin1]
#   This means that strings are converted to the given encoding before being sent to the client and also all strings
#   from the client are assumed to come from the given encoding.
#
# [eval=undef]
#   Preload packages with expressions that you would otherwise have to load from scripts.
#
# [fileio='enable'|'disable']
#   Allow clients to perform filesystem operations via the RServe deamon.
#
# [gid=97)
#   The group id of the 'rserve' user runnning the daemon.
#
# [interactive='yes'|'no']
#
# [maxinbuf=262144]
#   The maximum allowed buffer size in Kb send from the client per connection.
#
# [maxsendbuf=0]
#   The maximum allowed buffer size in Kb send from the server per connection.
#
# [password='rserve']
#   The password for connecting to the Binary R server daemon.
#
# [plaintext='disable'|'enable']
#   Allows for sending credentials as plaintext.
#
# [port=6311]
#   The TCP port the daemon listens too.
#
# [pwdfile='/etc/Rserve.pwd']
#   The password file containing the authentication credentials.
#
# [remote='enable'|'disable']
#   Allows remote connections when enabled.
#
# [socket=undef]
#
# [sockmod=undef]
#
# [source=undef]
#   Location to a file to preload packages that you would otherwise have to load from your scripts.
#
# [su=undef|now|server|client]
#   Undocumented.
#
# [uid=97]
#   The user id of the 'rserve' user running the daemon.
#
# [user='rserve']
#   The username for connecting to the Binary R server daemon.
#
# [umask=0]
#   Controls how file permissions are set for files.
#
# [workdir='/tmp/Rserv']
#   R working directory.
#
# === Examples
#
#   class { iqss:rserve
#     pwdfile => '/tip/top/secret',
#   }
#

class iqss::rserve (
  $auth              = $iqss::params::rserve_auth,
  $chroot            = $iqss::params::rserve_chroot,
  $encoding          = $iqss::params::rserve_encoding,
  $eval              = $iqss::params::rserve_eval,
  $fileio            = $iqss::params::rserve_fileio,
  $gid               = $iqss::params::rserve_gid,
  $interactive       = $iqss::params::rserve_interactive,
  $maxinbuf          = $iqss::params::rserve_maxinbuf,
  $maxsendbuf        = $iqss::params::rserve_maxsendbuf,
  $plaintext         = $iqss::params::rserve_plaintext,
  $port              = $iqss::params::rserve_port,
  $password          = $iqss::params::rserve_password,
  $pwdfile           = $iqss::params::rserve_pwdfile,
  $remote            = $iqss::params::rserve_remote,
  $socket            = $iqss::params::rserve_socket,
  $sockmod           = $iqss::params::rserve_sockmod,
  $source            = $iqss::params::rserve_source,
  $su                = $iqss::params::rserve_su,
  $uid               = $iqss::params::rserve_uid,
  $user              = $iqss::params::rserve_user,
  $umask             = $iqss::params::rserve_umask,
  $workdir           = $iqss::params::rserve_workdir,
) inherits iqss::params {


  if ! defined(Class['iqss::rpackager']) {
    class {
      'iqss::rpackager':
    }
  }

  class { 'iqss::rserve::service':
    require => Class['iqss::rpackager'];
  }

}