# = Puppet module for dataverse.
# == Class: Dataverse::Dataverse::Java::Install
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
# Install the package. When we install with the oracle installed, set the licence agreement

class dataverse::dataverse::java::install {

    class { '::java':
      package => $dataverse::dataverse::java::repo::java8_openjdk_package,
    }

}