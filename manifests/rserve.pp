# Puppet module for dataverse
# Copyright (C) 2015 {name of author}
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
#
# == Class: iqss::rserve
#
# Installs the RServe package with a Binary R server (a daemon) together with a range of R packages.
# Also see: https://rforge.net/Rserve/doc.html
#
# === Parameters
# [parameter='default'[|alternatives]]
#   Description
#
# [auth='disable'|'require']
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
# [source=undef]
#   Location to a file to preload packages that you would otherwise have to load from your scripts.
#
# [su=undef|now|server|client]
#   Undocumented.
#
# [uid=97]
#   The user id of the 'rserve' user running the daemon.
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
  $pwdfile           = $iqss::params::rserve_pwdfile,
  $remote            = $iqss::params::rserve_remote,
  $socket            = $iqss::params::rserve_socket,
  $sockmod           = $iqss::params::rserve_sockmod,
  $source            = $iqss::params::rserve_source,
  $su                = $iqss::params::rserve_su,
  $uid               = $iqss::params::rserve_uid,
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