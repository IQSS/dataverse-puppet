# = Puppet module for dataverse.
# == Class: Dataverse::Tworavens::Config
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
# Set the configuration. TwoRavens does not have a configuration file as such, hence the source code is altered here.
#
class dataverse::tworavens::config {

# Depending on the OS:
  case $::osfamily {
    'redhat': {
      file {
        "${::apache::confd_dir}/tworavens-rapache.conf":
          ensure  => file,
          content => template('dataverse/tworavens/tworavens-rapache.conf.erb'),
          notify  => Service[$::apache::service_name];
      }
    }
    'debian': {
      file {
        "${::apache::vhost_dir}/tworavens-rapache.conf":
          ensure  => file,
          content => template('dataverse/tworavens/tworavens-rapache.conf.erb'),
          notify  => Service[$::apache::service_name];
        "${::apache::vhost_enable_dir}/35-tworavens.conf":
          ensure => link,
          target => "${::apache::vhost_dir}/tworavens-rapache.conf";
      }
    }
    default: {
      fail("OSFamily ${::osfamily} is not currently supported.")
    }
  }


  file_line {
    'rookdata production':
      ensure  => present,
      path    => "${dataverse::tworavens::dataexplore_dir}/rook/rookdata.R",
      line    => 'production<-TRUE',
      match   => 'production<-FALSE';
    'rookzelig production':
      ensure  => present,
      path    => "${dataverse::tworavens::dataexplore_dir}/rook/rookzelig.R",
      line    => 'production<-TRUE',
      match   => 'production<-FALSE';
    'rooksubset production':
      ensure  => present,
      path    => "${dataverse::tworavens::dataexplore_dir}/rook/rooksubset.R",
      line    => 'production<-TRUE',
      match   => 'production<-FALSE';
    'rooktransform production':
      ensure  => present,
      path    => "${dataverse::tworavens::dataexplore_dir}/rook/rooktransform.R",
      line    => 'production<-TRUE',
      match   => 'production<-FALSE';
    'rookselector production':
      ensure  => present,
      path    => "${dataverse::tworavens::dataexplore_dir}/rook/rookselector.R",
      line    => 'production<-TRUE',
      match   => 'production<-FALSE';
    'rooksource production':
      ensure  => present,
      path    => "${dataverse::tworavens::dataexplore_dir}/rook/rooksource.R",
      line    => 'production<-TRUE',
      match   => 'production<-FALSE';
    'rooksource working directory':
      ensure  => present,
      path    => "${dataverse::tworavens::dataexplore_dir}/rook/rooksource.R",
      line    => "setwd('${dataverse::tworavens::dataexplore_dir}/rook')"  ,
      match   => 'setwd';
    'rookutils url':
      ensure  => present,
      path    => "${dataverse::tworavens::dataexplore_dir}/rook/rookutils.R",
      line    => "url <- paste('${dataverse::tworavens::protocol}://${dataverse::tworavens::fqdn}:${dataverse::tworavens::port}/custom/preprocess_dir/preprocessSubset_',sessionid,'.txt',sep='')",
      match   => 'dataverse-demo.iq.harvard.edu/custom/preprocess_dir/preprocessSubset_';
    'rookutils imagevector':
      ensure  => present,
      path    => "${dataverse::tworavens::dataexplore_dir}/rook/rookutils.R",
      line    => "imageVector[[qicount]]<<-paste('${dataverse::tworavens::protocol}://${dataverse::tworavens::fqdn}:${dataverse::tworavens::port}/custom/pic_dir/', mysessionid,'_',mymodelcount,qicount,'.png', sep = '')",
      match   => 'dataverse-demo.iq.harvard.edu/custom/pic_dir/';
    'app_ddi production':
      ensure  => present,
      path    => "${dataverse::tworavens::dataexplore_dir}/app_ddi.js",
      line    => 'var production=true;',
      match   => 'production=false';
    'app_ddi hostname':
      ensure  => present,
      path    => "${dataverse::tworavens::dataexplore_dir}/app_ddi.js",
      line    => "hostname='${dataverse::tworavens::dataverse_fqdn}:${dataverse::tworavens::dataverse_port}';",
      match   => 'hostname="dataverse-demo.iq.harvard.edu"';
    'app_ddi production_dataverse_url':
      ensure  => present,
      path    => "${dataverse::tworavens::dataexplore_dir}/app_ddi.js",
      line    => "dataverseurl='${dataverse::tworavens::protocol}://${dataverse::tworavens::dataverse_fqdn}:${dataverse::tworavens::dataverse_port}';",
      match   => 'PRODUCTION_DATAVERSE_URL';
    'app_ddi rappURL':
      ensure  => present,
      path    => "${dataverse::tworavens::dataexplore_dir}/app_ddi.js",
      line    => "var rappURL = '${dataverse::tworavens::protocol}://${dataverse::tworavens::fqdn}:${dataverse::tworavens::port}/custom/';",
      match   => 'var rappURL = "https://dataverse-demo.iq.harvard.edu/custom/"';
  }

}