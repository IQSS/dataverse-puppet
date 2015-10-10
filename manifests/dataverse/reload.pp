# = Puppet module for dataverse.
# == Class: Iqss::Dataverse::Reload
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
#
class iqss::dataverse::reload {

  $path    = "${iqss::dataverse::home}/bin:/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin"
  $restart = "asadmin restart-domain ${iqss::dataverse::glassfish_domain_name}"

  exec {
    'restart deployed':
      command     => "cp \"${iqss::dataverse::domain}/config/domain.deployed.xml\" \"${iqss::dataverse::domain}/config/domain.xml\" ; ${restart}",
      path        => $path,
      refreshonly => true,
      subscribe   => File['deployed'],
      onlyif      => "test -d ${iqss::dataverse::domain}/applications/${iqss::dataverse::package}" ;
  }

  exec {
    'start undeployed':
      command     => "cp \"${iqss::dataverse::domain}/config/domain.undeployed.xml\" \"${iqss::dataverse::domain}/config/domain.xml\" ; ${restart}",
      path        => $path,
      unless      => "test -d ${iqss::dataverse::domain}/applications/${iqss::dataverse::package}" ;
  }


}