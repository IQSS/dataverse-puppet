# PRIVATE CLASS: do not use directly. To change settings use the inherited classes or Iqss::Globals
# Variable name convention whereever possible: classname_keyname=default|Iqss::Globals::classname_keyname
class iqss::params inherits iqss::globals {
  $apache2_default_confd_files                      = false
  $apache2_default_mods                             = false
  $apache2_default_ssl_vhost                        = false
  $apache2_default_vhost                            = false
  $apache2_purge_configs                            = $iqss::globals::apache2_purge_configs
  $database_createdb                                = false
  $database_encoding                                = 'UTF-8'
  $database_host                                    = $iqss::globals::database_host
  $database_locale                                  = 'en_US.UTF-8'
  $database_port                                    = $iqss::globals::database_port
  $database_name                                    = $iqss::globals::database_name
  $database_user                                    = $iqss::globals::database_user
  $database_password                                = $iqss::globals::database_password
  $database_hba_rule                                = {
    'IPv4 local connections' => {
      'description' => 'Open up a IP4 connection from localhost',
      'type'=> 'host',
      'database'=> $database_name,
      'user'=> $database_user,
      'address'=> '127.0.0.1/32',
      'auth_method'=> 'md5'
    } ,
    'IPv6 local connections' => {
      'description'=> 'Open up a IP6 connection from localhost',
      'type'=> 'host',
      'database'=> $database_name,
      'user'=> $database_user,
      'address'=> '::1/128',
      'auth_method'=> 'md5'
    }
  }
  $database_login                                   = true
  $database_manage_package_repo                     = true
  $database_superuser                               = false
  $database_listen_addresses                        = 'localhost'
  $database_replication                             = false
  $database_createrole                              = false
  $database_version                                 = '9.3'
  $dataverse_auth_password_reset_timeout_in_minutes = '60'
  $dataverse_files_directory                        = '/home/glassfish/dataverse/files'
  $dataverse_fqdn                                   = $iqss::globals::dataverse_fqdn
  $dataverse_port                                   = $iqss::globals::dataverse_port
  $dataverse_rserve_host                            = $iqss::globals::dataverse_fqdn
  $dataverse_rserve_port                            = '6311'
  $dataverse_rserve_password                        = $iqss::globals::rserve_pwd
  $dataverse_rserve_user                            = 'rserve'
  $dataverse_site_url                               = "https://${dataverse_fqdn}:${dataverse_port}"
  $doi_baseurlstring                                = 'https://ezid.cdlib.org'
  $doi_password                                     = 'apitest'
  $doi_username                                     = 'apitest'
  $ensure                                           = 'present'
  $glassfish_create_domain                          = true
  $glassfish_fromaddress                            = 'do-not-reply@localhost'
  $glassfish_parent_dir                             = '/usr/local'
  $glassfish_domain_name                            = 'domain1'
  $glassfish_jvmoption                              = [ '-XX:MaxPermSize=512m', '-XX:PermSize=256m', '-Xmx1024m', '-Djavax.xml.parsers.SAXParserFactory=com.sun.org.apache.xerces.internal.jaxp.SAXParserFactoryImpl' ]
  $glassfish_mailhost                               = 'localhost'
  $glassfish_mailproperties                         = 'username=a_username:password=a_password'
  $glassfish_mailuser                               = 'dataversenotify'
  $glassfish_remove_default_domain                  = false
  $glassfish_service_name                           = 'dataverse'
  $glassfish_tmp_dir                                = '/opt/glassfish'
  $glassfish_user                                   = 'glassfish'
  $glassfish_version                                = '4.1'
  $repository                                       = 'https://github.com/IQSS/dataverse/releases/download/v4.0.1/dataverse-4.0.1.war'

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
    'Rserve'    => { version => '1.7-3' },
    'R2HTML'    => { version => '2.3.1' },
    'rjson'     => { version => '0.2.15' },
    'VGAM'      => { version => '0.9-8' }
  }
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
  $rserve_pwd                                       = $iqss::globals::rserve_pwd
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
  $solr_url                                         = 'http://archive.apache.org/dist/lucene/solr'
  $solr_version                                     = '4.6.0'
  $solr_solr_parent_dir                             = "/usr/local/solr-${solr_version}"
  $solr_jetty_home                                  = "${solr_solr_parent_dir}/example"
  $solr_jetty_java_options                          = '-Xmx512m'
  $solr_jetty_host                                  = $iqss::globals::dataverse_fqdn
  $solr_jetty_port                                  = '8983'
  $solr_jetty_user                                  = 'solr'
  $solr_solr_home                                   = "${solr_solr_parent_dir}/example/solr"
  $tworavens_domain                                 = $iqss::globals::dataverse_fqdn
  $tworavens_package                                = 'https://github.com/IQSS/TwoRavens/archive/master.zip'
  $tworavens_parent_dir                             = '/var/www/html'
  $tworavens_port                                   = 443
  $tworavens_protocol                               = 'https'
  $tworavens_rapache_version                        = '1.2.6'



# Here we determine package names and versions based on the OS
  case $::osfamily {
    'redhat': {
      $solr_required_packages  = ['java-1.7.0-openjdk']
      $solr_java_home = '/usr/lib/jvm/jre-1.7.0-openjdk.x86_64'
      $apache_mods = [  'apache::mod::alias',
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
        'R', 'R-devel', 'libapreq2', 'libcurl-devel', 'libxml2-devel', 'openssl-devel', 'libXt-devel', 'mesa-libGL-devel', 'mesa-libGLU-devel', 'libpng-devel'
      ]
      $shibboleth_lib = '/usr/lib64/shibboleth/mod_shib_22.so'
      $mod_r_so_file  = '/etc/httpd/modules/mod_R.so'
      $r_site_library = '/usr/lib64/R/library'
    }
    'debian': {
      $solr_required_packages = ['openjdk-7-jre']
      $solr_java_home = '/usr/lib/jvm/java-7-openjdk-amd64/jre'
      $rpackager_rstudio_libraries = $::lsbdistcodename ? {
        'trusty' => [
          'r-base', 'r-base-core', 'r-base-dev', 'libcurl4-openssl-dev', 'libpq-dev', 'libxml2-dev', 'libcurl4-gnutls-dev', 'libapreq2-3'
        ],
        /(precise|default)/ => [
          'r-base', 'r-base-core', 'r-base-dev', 'libcurl4-openssl-dev', 'libpq-dev', 'libxml2-dev', 'libcurl4-gnutls-dev', 'libapreq2', 'libglu1-mesa-dev', 'freeglut3-dev', 'mesa-common-dev'
        ],
      }

      $shibboleth_lib = $::lsbdistcodename ? {
        'trusty' => '/usr/lib/apache2/modules/mod_shib2.so' ,
        /(precise|default)/ => '/usr/lib/apache2/modules/mod_shib_22.so'
      }
      $mod_r_so_file = '/usr/lib/apache2/modules/mod_R.so'
      $r_site_library = '/usr/local/lib/R/site-library'

      $apache_mods = $::lsbdistcodename ? {
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