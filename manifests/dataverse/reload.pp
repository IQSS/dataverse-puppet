# = Puppet module for dataverse.
# == Class: Dataverse::Dataverse::Reload
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
# Install the domain.xml with the settings. There are two here. One for when the war is not deployed.
# And the other for when it is.

class dataverse::dataverse::reload {

  $path    = "${dataverse::dataverse::home}/bin:/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin"
  $restart = "asadmin restart-domain ${dataverse::dataverse::glassfish_domain_name}"

  exec {
    'restart deployed':
      command     => "cp \"${dataverse::dataverse::domain}/config/domain.deployed.xml\" \"${dataverse::dataverse::domain}/config/domain.xml\" ; ${restart}",
      path        => $path,
      refreshonly => true,
      subscribe   => File['deployed'],
      onlyif      => "test -d ${dataverse::dataverse::domain}/applications/${dataverse::dataverse::_package}" ;
  }

  exec {
    'start undeployed':
      command     => "cp \"${dataverse::dataverse::domain}/config/domain.undeployed.xml\" \"${dataverse::dataverse::domain}/config/domain.xml\" ; ${restart}",
      path        => $path,
      unless      => "test -d ${dataverse::dataverse::domain}/applications/${dataverse::dataverse::_package}" ;
  }


}