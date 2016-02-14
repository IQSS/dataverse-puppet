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
# Install java 1.8

class dataverse::dataverse::java {

  anchor { 'dataverse::dataverse::java::start': }->
  class { 'dataverse::dataverse::java::repo': }->
  class { 'dataverse::dataverse::java::install': }->
  anchor { 'dataverse::dataverse::java::end': }

}