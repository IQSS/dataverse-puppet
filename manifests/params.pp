# = Puppet module for dataverse.
# == Class: Iqss::Params
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
# These are default settings. To overwrite them use the inherited classes.
#
# Variable name convention possible: classname_keyname=default value

class iqss::params {
  $apache2_default_confd_files                      = false
  $apache2_default_mods                             = false
  $apache2_default_ssl_vhost                        = false
  $apache2_default_vhost                            = false
  $apache2_purge_configs                            = true

  $database_createdb                                = false
  $database_createrole                              = false
  $database_dbname                                  = 'dvndb'
  $database_encoding                                = 'UTF-8'
  $database_hba_rule                                = {
    'IPv4 local connections' => {
      'description' => 'Open up a IP4 connection from localhost',
      'type'=> 'host',
      'database'=> $database_dbname,
      'user'=> $database_user,
      'address'=> '127.0.0.1/32',
      'auth_method'=> 'md5'
    } ,
    'IPv6 local connections' => {
      'description'=> 'Open up a IP6 connection from localhost',
      'type'=> 'host',
      'database'=> $database_dbname,
      'user'=> $database_user,
      'address'=> '::1/128',
      'auth_method'=> 'md5'
    }
  }
  $database_listen_addresses                        = '*'
  $database_locale                                  = 'en_US.UTF-8'
  $database_login                                   = true
  $database_manage_package_repo                     = true
  $database_password                                = 'dvnAppPass'
  $database_replication                             = false
  $database_superuser                               = false
  $database_user                                    = 'dvnApp'
  $database_version                                 = '9.3'

  $dataverse_auth_password_reset_timeout_in_minutes = 60
  $allow_http                                       = false
  $dataverse_doi_baseurlstring                      = 'https://ezid.cdlib.org'
  $dataverse_doi_password                           = 'apitest'
  $dataverse_doi_username                           = 'apitest'
  $dataverse_files_directory                        = '/home/glassfish/dataverse/files'
  $dataverse_fqdn                                   = 'localhost'
  $dataverse_glassfish_create_domain                = true
  $dataverse_glassfish_fromaddress                  = 'do-not-reply@localhost'
  $dataverse_glassfish_parent_dir                   = '/home/glassfish'
  $dataverse_glassfish_domain_name                  = 'domain1'
  $dataverse_glassfish_jvmoption                    = [
'-XX:MaxPermSize=512m',
'-XX:PermSize=256m',
'-Xmx1024m',
'-Djavax.xml.parsers.SAXParserFactory=com.sun.org.apache.xerces.internal.jaxp.SAXParserFactoryImpl'
]
  $dataverse_glassfish_mailhost                     = 'localhost'
  $dataverse_glassfish_mailproperties               = {
'username' => 'a username',
'password' => 'a password'
}
  $dataverse_glassfish_mailuser                     = 'dataversenotify'
  $dataverse_glassfish_remove_default_domain        = false
  $dataverse_glassfish_service_name                 = 'glassfish'
  $dataverse_glassfish_tmp_dir                      = '/opt/glassfish'
  $dataverse_glassfish_user                         = 'glassfish'
  $dataverse_glassfish_version                      = '4.1'
  $dataverse_package                                = 'dataverse-4.2.1'
  $dataverse_port                                   = 443
  $dataverse_repository                             = "https://github.com/IQSS/dataverse/releases/download/v4.2.1/dataverse-4.2.1.war"
  $dataverse_rserve_host                            = 'localhost'
  $dataverse_rserve_password                        = 'rserve'
  $dataverse_rserve_port                            = 6311
  $dataverse_rserve_user                            = 'rserve'
  $dataverse_site_url                               = "https://${dataverse_fqdn}:${dataverse_port}"

  $rpackager_packages                               = {
    'AER'       => { version => '1.2-4' },
    'Amelia'    => { version => '1.7.3' },
    'DescTools' => { version => '0.99.13' },
    'devtools'  => { version => '1.9.1' },
    'dplyr'     => { version => '0.4.3' },
    'geepack'   => { version => '1.2-0' },
    'jsonlite'  => { version => '0.9.17' },
    'maxLik'    => { version => '1.2-4' },
    'quantreg'  => { version => '5.19' },
    'Rook'      => { version => '1.1-1' },
    'RCurl'     => { version => '1.95-4.7' },
    'Rserve'    => { version => '1.7-3' },
    'R2HTML'    => { version => '2.3.1' },
    'rjson'     => { version => '0.2.15' },
    'VGAM'      => { version => '0.9-8' },
    'MCMCpack'  => { version => '1.3-3' }
  }

  $r_path                                           = '/usr/bin/R'
  $rpackager_packages_zelig                         = 'https://github.com/IQSS/Zelig/archive/master.zip'
  $rpackager_repo                                   = 'http://cran.r-project.org'


  $rserve_auth                                      = 'required'
  $rserve_chroot                                    = undef
  $rserve_encoding                                  = 'utf8'
  $rserve_eval                                      = undef
  $rserve_fileio                                    = 'enable'
  $rserve_gid                                       = 97
  $rserve_interactive                               = 'yes'
  $rserve_maxinbuf                                  = 262144
  $rserve_maxsendbuf                                = 0
  $rserve_user                                      = 'rserve'
  $rserve_plaintext                                 = 'disable'
  $rserve_port                                      = 6311
  $rserve_password                                  = 'rserve'
  $rserve_pwdfile                                   = '/etc/Rserv.pwd'
  $rserve_remote                                    = 'enable'
  $rserve_socket                                    = undef
  $rserve_sockmod                                   = 0
  $rserve_source                                    = undef
  $rserve_su                                        = undef
  $rserve_uid                                       = 97
  $rserve_umask                                     = 0
  $rserve_workdir                                   = '/tmp/Rserv'

  $solr_core                                        = 'collection1'
  $solr_jetty_host                                  = 'localhost'
  $solr_jetty_java_options                          = '-Xmx512m'
  $solr_jetty_port                                  = '8983'
  $solr_jetty_user                                  = 'solr'
  $solr_url                                         = 'http://archive.apache.org/dist/lucene/solr'
  $solr_version                                     = '4.6.0'
  $solr_parent_dir                                  = "/home/${solr_jetty_user}"
  $solr_jetty_home                                  = "${solr_parent_dir}/solr-${solr_version}/example"
  $solr_solr_home                                   = "${solr_jetty_home}/solr"

  $tworavens_dataverse_fqdn                         = 'localhost'
  $tworavens_dataverse_port                         = 443
  $tworavens_fqdn                                   = 'localhost'
  $tworavens_package                                = 'https://github.com/IQSS/TwoRavens/archive/master.zip'
  $tworavens_parent_dir                             = '/var/www/html'
  $tworavens_port                                   = 443
  $tworavens_protocol                               = 'https'
  $tworavens_rapache_version                        = '1.2.6'



# Here we determine package names and versions based on the OS
  case $::osfamily {
    'redhat': {
      $solr_required_packages  = ['java-1.7.0-openjdk']
      $apache2_mods = [  'apache::mod::alias',
        'apache::mod::auth_basic',
        'apache::mod::authn_file',
        'apache::mod::authz_default',
        'apache::mod::authz_user',
        'apache::mod::autoindex',
        'apache::mod::ssl',
        'apache::mod::deflate',
        'apache::mod::dir',
        'apache::mod::mime',
        'apache::mod::negotiation',
        'apache::mod::proxy',
        'apache::mod::proxy_ajp',
        'apache::mod::reqtimeout',
        'apache::mod::rewrite',
        'apache::mod::setenvif']
      $rpackager_rstudio_libraries = [
        'R',
        'R-devel',
        'libapreq2',
        'libcurl-devel',
        'libxml2-devel',
        'openssl-devel',
        'libXt-devel',
        'mesa-libGL-devel',
        'mesa-libGLU-devel',
        'libpng-devel'
      ]
      $apache2_shibboleth_lib = '/usr/lib64/shibboleth/mod_shib_22.so'
      $tworavens_mod_r_so_file  = '/etc/httpd/modules/mod_R.so'
      $rpackager_r_site_library = '/usr/lib64/R/library'
    }
    'debian': {
      $solr_required_packages = ['openjdk-7-jre']
      $rpackager_rstudio_libraries = $::lsbdistcodename ? {
        'trusty' => [
          'r-base',
          'r-base-core',
          'r-base-dev',
          'libcurl4-openssl-dev',
          'libpq-dev',
          'libxml2-dev',
          'libcurl4-gnutls-dev',
          'libapreq2-3',
          'r-cran-mcmcpack'
        ],
        /(precise|default)/ => [
          'r-base',
          'r-base-core',
          'r-base-dev',
          'libcurl4-openssl-dev',
          'libpq-dev',
          'libxml2-dev',
          'libcurl4-gnutls-dev',
          'libapreq2',
          'libglu1-mesa-dev',
          'freeglut3-dev',
          'mesa-common-dev',
          'r-cran-mcmcpack'
        ],
      }

      $apache2_shibboleth_lib = $::lsbdistcodename ? {
        'trusty' => '/usr/lib/apache2/modules/mod_shib2.so' ,
        /(precise|default)/ => '/usr/lib/apache2/modules/mod_shib_22.so'
      }
      $tworavens_mod_r_so_file = '/usr/lib/apache2/modules/mod_R.so'
      $rpackager_r_site_library = '/usr/local/lib/R/site-library'

      $apache2_mods = $::lsbdistcodename ? {
        'trusty' => [
          'apache::mod::alias',
          'apache::mod::authn_core',
          'apache::mod::autoindex',
          'apache::mod::ssl',
          'apache::mod::deflate',
          'apache::mod::dir',
          'apache::mod::mime',
          'apache::mod::negotiation',
          'apache::mod::proxy',
          'apache::mod::proxy_ajp',
          'apache::mod::reqtimeout',
          'apache::mod::rewrite',
          'apache::mod::setenvif',
        ]
      ,
        /(precise|default)/ => [
          'apache::mod::alias',
          'apache::mod::auth_basic',
          'apache::mod::authn_file',
          'apache::mod::authz_default',
          'apache::mod::authz_user',
          'apache::mod::autoindex',
          'apache::mod::ssl',
          'apache::mod::deflate',
          'apache::mod::dir',
          'apache::mod::mime',
          'apache::mod::negotiation',
          'apache::mod::proxy',
          'apache::mod::proxy_ajp',
          'apache::mod::reqtimeout',
          'apache::mod::rewrite',
          'apache::mod::setenvif',
        ]
      }
    }
    default: {
      fail('OSFamily ${::osfamily} is not currently supported.')
    }
  }

}