# = Puppet module for dataverse.
# == Class: Dataverse::Java
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
# Install java 1.8

class dataverse::java {

  anchor { 'dataverse::java::start': }->
  class { 'dataverse::java::repo': }->
  class { 'dataverse::java::install': }->
  anchor { 'dataverse::java::end': }

}