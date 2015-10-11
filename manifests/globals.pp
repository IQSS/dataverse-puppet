# = Puppet module for dataverse.
# == Class: Iqss::Globals
#
# === Copyright
#
# Puppet module for dataverse.
# GPLv3 - Copyright (C) 2015 International Institute of Social History <socialhistory.org>.
#
# === Description
#
# Overal must have packages.
#  - unzip.
#
# === Parameters
#
# [required_packages=['unzip']]
#   A list of packages.
#

class iqss::globals (
  $required_packages = ['unzip'],
) {
  package {
    $required_packages:
      ensure => installed,
  }
}