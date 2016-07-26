# = Puppet module for dataverse.
# == Class: Dataverse::Dataverse
#
# === Copyright
#
# Puppet module for dataverse.
# GPLv3 - Copyright (C) 2015 International Institute of Social History <socialhistory.org>.
#
# === Description
#
# This installs a Dataverse server.
# By default we will install glassfish in /home/glassfish like described in:
# https://glassfish.java.net/docs/4.0/installation-guide.pdf
#
# === Parameters
#
# [auth_password_reset_timeout_in_minutes=60]
#   The time in minutes for a password reset.
#
# [allow_http=false]
#   Allow a http connection. If false, redirect traffic to https. Set to true for a development server or when you use
#   a proxy for SSL termination.
#
# [files_directory='/home/glassfish/dataverse/files']
#   The location of the uploaded files and their tabular derivatives.
#
# [database_dbname='dvndb']
#   The name of the database.
#
# [database_host='localhost']
#   The resolvable hostname of the database.
#
# [database_password='dvnAppPass']
#   The database user's password
#
# [database_port=5432]
#   The database port.
#
# [database_user='dvnApp']
#   The username granted control over the database.
#
# [doi_baseurlstring='https://ezid.cdlib.org']
#   The DOI endpoint for the EZID Service.
#
# [doi_username='apitest']
#   The username to connect to the EZID Service.
#
# [doi_password='apitest']
#   The password to connect to the EZID Service.
#
# [fqdn='localhost']
#   The domain name of the web application. If the Dataverse server has multiple DNS names, this option specifies the
#   one to be used as the "official" host name.
#   For example, you may want to have dataverse.foobar.edu, and not the less appealing server-123.socsci.foobar.edu to
#   appear exclusively in all the registered global identifiers, Data Deposit API records, etc. Defaults to 'localhost'.
#
#   Do note that whenever the system needs to form a service URL, by default, it will be formed with https:// and port 443.
#   I.e. https://{dataverse.fqdn}/
#
#   If that does not suit your setup, use the `Dataverse::Dataverse::site_url` option.
#
# [glassfish_domain='domain1']
#   The domain name.
#
# [glassfish_fromaddres='do-not-reply@localhost']
#   The e-mail -from field in the mail header ( if any ).
#
# [glassfish_jvmoption=[-XX:MaxPermSize=512m', '-XX:PermSize=256m', '-Xmx1024m',
#   -Djavax.xml.parsers.SAXParserFactory=com.sun.org.apache.xerces.internal.jaxp.SAXParserFactoryImpl']
#   An array of jvm options.
#
# [glassfish_mailhost='localhost']
#   The mail relay hostname.
#
# [glassfish_mailproperties={'username' => 'a username', 'password' => 'a password'}
#   Key-value pairs sent with to the mail relay, such as credentials.
#
# [glassfish_manage_java=false|true]
#   Java installation is managed by glassfish.
#
# [glassfish_parent_dir='/home/glassfish']
#   The Glassfish parent directory.
#
# [glassfish_service_name='glassfish']
#   The service handle for start, stop, status commands.
#   E.g. service glassfish start.
#
# [glassfish_version='4.1']
#   The Glassfish J2EE Application server version.
#
# === Variables
#
# [home='/home/glassfish/glassfish-${version}/glassfish']
#   The root path of the glassfish installation.
#
# [domain='${home}/domains/{domainname}
#   The root path of the domain of the application.
#
# [glassfish_create_domain=true]
#   Create a domain after Glassfish is installed.
#
# [glassfish_remove_default_domain=true|false]
#   Removes the domain that was installed during the Glassfish installation.
#
# [glassfish_tmp_dir='/opt/glassfish']
#   The download path of the glassfish package.
#
# [glassfish_user='glassfish']
#   The user running the glassfish domain.
#
# [package='dataverse-4.4|dataverse-4.3.1|dataverse-4.3|dataverse-4.2.4|dataverse-4.2.3|dataverse-4.2.2|dataverse-4.2.1'|dataverse-4.2|dataverse-4.1|dataverse-4.0.1|dataverse-4.0]
#   The release tag: name and version of dataverse.
#
# [port=443]
#   The SSL port on which dataverse can be reached.
#
# [repository='https://github.com/IQSS/dataverse/releases/download/v4.4/dataverse-4.4.war']
#   This indicates there the package comes from. It can be 'git' to build a war from the IQSS repository master branch;
#   or the repository url of a Dataverse war file.
#
# [rserve_host='localhost']
#   The Rserve service endpoint.
#
# [rserve_password='rserve']
#   The password needed to access the Rserve service.
#
# [rserve_port=6311]
#   The Rserve service endpoint's port.
#
# [rserve_user='rserve']
#   The username that can access the Rserce service.
#
# [site_url='https://localhost:443']
#   The url to a dataverse web application.

class dataverse::dataverse (
  $auth_password_reset_timeout_in_minutes = $dataverse::params::dataverse_auth_password_reset_timeout_in_minutes,
  $allow_http                             = $dataverse::params::dataverse_allow_http,
  $files_directory                        = $dataverse::params::dataverse_files_directory,
  $database_dbname                        = $dataverse::params::database_dbname,
  $database_host                          = $dataverse::params::dataverse_database_host,
  $database_password                      = $dataverse::params::database_password,
  $database_port                          = $dataverse::params::dataverse_database_port,
  $database_user                          = $dataverse::params::database_user,
  $doi_baseurlstring                      = $dataverse::params::dataverse_doi_baseurlstring,
  $doi_username                           = $dataverse::params::dataverse_doi_username,
  $doi_password                           = $dataverse::params::dataverse_doi_password,
  $files_directory                        = $dataverse::params::dataverse_files_directory,
  $fqdn                                   = $dataverse::params::dataverse_fqdn,
  $glassfish_create_domain                = $dataverse::params::dataverse_glassfish_create_domain,
  $glassfish_domain_name                  = $dataverse::params::dataverse_glassfish_domain_name,
  $glassfish_fromaddress                  = $dataverse::params::dataverse_glassfish_fromaddress,
  $glassfish_jvmoption                    = $dataverse::params::dataverse_glassfish_jvmoption,
  $glassfish_mailhost                     = $dataverse::params::dataverse_glassfish_mailhost,
  $glassfish_mailuser                     = $dataverse::params::dataverse_glassfish_mailuser,
  $glassfish_mailproperties               = $dataverse::params::dataverse_glassfish_mailproperties,
  $glassfish_manage_java                  = $dataverse::params::dataverse_glassfish_manage_java,
  $glassfish_parent_dir                   = $dataverse::params::dataverse_glassfish_parent_dir,
  $glassfish_service_name                 = $dataverse::params::dataverse_glassfish_service_name,
  $glassfish_version                      = $dataverse::params::dataverse_glassfish_version,
  $package                                = $dataverse::params::dataverse_package,
  $port                                   = $dataverse::params::dataverse_port,
  $repository                             = $dataverse::params::dataverse_repository,
  $rserve_host                            = $dataverse::params::dataverse_rserve_host,
  $rserve_password                        = $dataverse::params::dataverse_rserve_password,
  $rserve_port                            = $dataverse::params::dataverse_rserve_port,
  $rserve_user                            = $dataverse::params::dataverse_rserve_user,
  $site_url                               = $dataverse::params::dataverse_site_url,

) inherits dataverse::params {

  $home                            = "${dataverse::dataverse::glassfish_parent_dir}/glassfish-${dataverse::dataverse::glassfish_version}/glassfish"
  $domain                          = "${home}/domains/${dataverse::dataverse::glassfish_domain_name}"
  $glassfish_remove_default_domain = $dataverse::params::dataverse_glassfish_remove_default_domain
  $glassfish_tmp_dir               = $dataverse::params::dataverse_glassfish_tmp_dir
  $glassfish_user                  = $dataverse::params::dataverse_glassfish_user

  case $package {
    'dataverse-4.4', default: {
      $_package = 'dataverse-4.4'
      $msg = 'This release contains feature enhancements for embedding content using widgets, downloading guestbook data for a dataverse in a consolidated fashion, and introduces a new feature, support for remote authentication using Shibboleth.'
    }
    'dataverse-4.3.1': {
      $_package = 'dataverse-4.3.1'
      $msg = 'This release is a small patch release to address a potential security issue discovered by Andy Boughton. It also includes some unrelated minor changes.'
    }
    'dataverse-4.2.4': {
      $_package = 'dataverse-4.2.4'
      $msg = 'This is a patch release to address issues with harvested dataset links and correct the behavior of zip downloads when selecting restricted files to which you do not have permission. There are a few other corrections such as fixing the :ZipDownloadLimit setting, allowing a Dataverse installation administrator to adjust the maximum amount of data that can be downloaded at one time.'
    }
    'dataverse-4.2.3': {
      $_package = 'dataverse-4.2.3'
      $msg = 'This release is small in scope; it\'s mostly about a technology upgrade that includes moving to Java 8 and upgrading to Prime Faces 5.3. We have fixed a number of issues, including making the file ingest page refresh more reliable.'
    }
    'dataverse-4.2.2': {
      $_package = 'dataverse-4.2.2'
      $msg = 'Dataverse v4.2.2 is focused on improving performance of the Dataverse page and Files facet. Additionally, several important support issues were addressed.'
    }
    'dataverse-4.2.1': {
      $_package = 'dataverse-4.2.1'
      $msg = 'Dataverse v4.2.1 is focused on improving performance of the dataset page and system stability by greatly reducing the number database calls made and limiting to 25 the number of files displayed on initialization. In addition, the SWORD API performance was improved to allow retrieval of file listings with large numbers of files.'
    }
    'dataverse-4.2': {
      $_package = 'dataverse-4.2'
      $msg = 'Dataverse v4.2 is focused on improving performance of the files and permissions pages as well as adding batch editing of files.'
    }
    'dataverse-4.1': {
      $_package = $_package
      $msg = 'Dataverse v4.1 is a minor release that contains two notable features: My Data and a manage groups UI. Bug fixes include: an updated Two Ravens installer, user guide updates, several API fixes, and a patch to the Grizzly subsystem that was preventing us from fronting Glassfish by Apache.'
    }
    'dataverse-4.0.1': {
      $_package = $_package
      $msg = 'Dataverse v4.0.1 is a point release that is mostly about bug fixes and clean up tasks following the v4.0 release.'
    }
    'dataverse-4.0': {
      $_package = $_package
      $msg = 'Dataverse 4.0 is completely rewritten and focused on improving usability, extending support to multiple disciplines, enhanced API support, and an improved permissions model. This list of new features and changes is not exhaustive, see the user guides and GitHub project for more information.'
    }
  }

  notify {
    "Configuration for package ${_package}":
      message => $msg ;
  }

  anchor { 'dataverse::dataverse::start': }->
  class { 'dataverse::dataverse::install': }->
  class { 'dataverse::dataverse::reload': }->
  class { 'dataverse::dataverse::war': }->
  class { 'dataverse::dataverse::deploy': }->
  class { 'dataverse::dataverse::vhost': }->
  anchor { 'dataverse::dataverse::end': }


}