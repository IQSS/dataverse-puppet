# = Puppet module for dataverse.
# == Class: Dataverse::Rpackager::Repo
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
# For redhat we use the R repo that comes with the OS.
# For Ubuntu we use the first one on this list:
# https://cran.r-project.org/mirrors.html
#
class dataverse::rpackager::repo {

  case $::osfamily {
    'redhat': {
      package {
        'epel-release':
          ensure => present,
      }
    }
    'debian': {
      apt::source { 'cran':
        comment    => 'This is the Ubuntu Debian repository for R and its packages',
        location   => "${dataverse::rpackager::repo}/bin/linux/ubuntu",
        repos      => "${::lsbdistcodename}/",
        release    => ' ', # The space prevents the default lsbdistcodename
        key        => 'E298A3A825C0D65DFD57CBB651716619E084DAB9',
        key_server => 'hkp://keyserver.ubuntu.com:80',
      }
    }
    default: {
      fail("OSFamily ${::osfamily} is not currently supported.")
    }
  }

}