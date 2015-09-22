# Reload the domain
class iqss::dataverse::reload {

  $path    = "${iqss::dataverse::home}/bin:/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin"
  $restart = "asadmin restart-domain ${iqss::dataverse::glassfish_domain_name}"

  exec {
    'restart deployed': # Restart the domain  so we can load the added libraries and -Xms, -Xmx settings we added in ::config and ::install
      command     => "cp \"${iqss::dataverse::domain}/config/domain.deployed.xml\" \"${iqss::dataverse::domain}/config/domain.xml\" ; ${restart}",
      path        => $path,
      refreshonly => true,
      subscribe   => File['deployed'],
      onlyif      => "test -d ${iqss::dataverse::domain}/applications/${iqss::dataverse::package}" ;
  }

  exec {
    'restart undeployed': # Restart the domain  so we can load the added libraries and -Xms, -Xmx settings we added in ::config and ::install
      command     => "cp \"${iqss::dataverse::domain}/config/domain.undeployed.xml\" \"${iqss::dataverse::domain}/config/domain.xml\" ; ${restart}",
      path        => $path,
      refreshonly => true,
      subscribe   => File['undeployed'],
      unless      => "test -d ${iqss::dataverse::domain}/applications/${iqss::dataverse::package}" ;
  }


}