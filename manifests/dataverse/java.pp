# = Puppet module for dataverse.
# == Class: Dataverse::Dataverse::Java
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
# Install's the appropriate repository and java package.
# For Ubuntu we will fall back on the build from Oracle. We need not do so for more recent versions of
# Ubuntu, but rather than make an exeption for Ubuntu 12, we just use the Oracle installation utility.
#
# For Centos we fall back on its own repository.

class dataverse::dataverse::java {

  anchor { 'dataverse::dataverse::java::start': }->
  class { 'dataverse::dataverse::java::repo': }->
  class { 'dataverse::dataverse::java::install': }->
  anchor { 'dataverse::dataverse::java::end': }

}