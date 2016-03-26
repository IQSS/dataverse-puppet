# = Puppet module for dataverse.
# == Class: Dataverse::Java::Install
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
# Install the package. When we install with the oracle, set the licence agreement

class dataverse::java::install {

    class { '::java':
      java_alternative => $dataverse::java::repo::java_alternative,
      java_alternative_path => $dataverse::java::repo::java_alternative_path,
      package => $dataverse::java::repo::package,
    }

}