class iqss::dataverse::reload {

  exec {
    'restart': # Restart so we can load the added libraries and -Xms, -Xmx settings we added in ::config and ::install
      command => "asadmin restart-domain ${iqss::dataverse::glassfish_domain_name}",
      path    => "${iqss::dataverse::glassfish_parent_dir}/glassfish-${iqss::dataverse::glassfish_version}/bin:/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin";
  }

}