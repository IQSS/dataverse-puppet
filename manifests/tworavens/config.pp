class iqss::tworavens::config {

# Depending on the OS:
  case $::osfamily {
    'redhat': {
      file {
        "${::apache::confd_dir}/tworavens-rapache.conf":
          ensure  => file,
          content => template('iqss/tworavens/tworavens-rapache.conf.erb'),
          notify  => Service[$::apache::service_name];
      }
    }
    'debian': {
      file {
        "${::apache::vhost_dir}/tworavens-rapache.conf":
          ensure  => file,
          content => template('iqss/tworavens/tworavens-rapache.conf.erb'),
          notify  => Service[$::apache::service_name];
        "${::apache::vhost_enable_dir}/35-tworavens.conf":
          ensure => link,
          target => "${::apache::vhost_dir}/tworavens-rapache.conf";
      }
    }
  }


  file_line {
    'rookdata production':
      ensure  => present,
      path    => "${iqss::tworavens::dataexplore_dir}/rook/rookdata.R",
      line    => 'production<-TRUE',
      match   => 'production<-FALSE';
    'rookzelig production':
      ensure  => present,
      path    => "${iqss::tworavens::dataexplore_dir}/rook/rookzelig.R",
      line    => 'production<-TRUE',
      match   => 'production<-FALSE';
    'rooksubset production':
      ensure  => present,
      path    => "${iqss::tworavens::dataexplore_dir}/rook/rooksubset.R",
      line    => 'production<-TRUE',
      match   => 'production<-FALSE';
    'rooktransform production':
      ensure  => present,
      path    => "${iqss::tworavens::dataexplore_dir}/rook/rooktransform.R",
      line    => 'production<-TRUE',
      match   => 'production<-FALSE';
    'rookselector production':
      ensure  => present,
      path    => "${iqss::tworavens::dataexplore_dir}/rook/rookselector.R",
      line    => 'production<-TRUE',
      match   => 'production<-FALSE';
    'rooksource production':
      ensure  => present,
      path    => "${iqss::tworavens::dataexplore_dir}/rook/rooksource.R",
      line    => 'production<-TRUE',
      match   => 'production<-FALSE';
    'rooksource working directory':
      ensure  => present,
      path    => "${iqss::tworavens::dataexplore_dir}/rook/rooksource.R",
      line    => "setwd('${iqss::tworavens::dataexplore_dir}/rook')"  ,
      match   => 'setwd';
    'rookutils url':
      ensure  => present,
      path    => "${iqss::tworavens::dataexplore_dir}/rook/rookutils.R",
      line    => "url <- paste('${iqss::tworavens::protocol}://${iqss::tworavens::domain}:${iqss::tworavens::port}/custom/preprocess_dir/preprocessSubset_',sessionid,'.txt',sep='')",
      match   => 'dataverse-demo.iq.harvard.edu/custom/preprocess_dir/preprocessSubset_';
    'rookutils imagevector':
      ensure  => present,
      path    => "${iqss::tworavens::dataexplore_dir}/rook/rookutils.R",
      line    => "imageVector[[qicount]]<<-paste('${iqss::tworavens::protocol}://${iqss::tworavens::domain}:${iqss::tworavens::port}/custom/pic_dir/', mysessionid,'_',mymodelcount,qicount,'.png', sep = '')",
      match   => 'dataverse-demo.iq.harvard.edu/custom/pic_dir/';
    'app_ddi production':
      ensure  => present,
      path    => "${iqss::tworavens::dataexplore_dir}/app_ddi.js",
      line    => 'var production=true;',
      match   => 'production=false';
    'app_ddi hostname':
      ensure  => present,
      path    => "${iqss::tworavens::dataexplore_dir}/app_ddi.js",
      line    => "hostname='${iqss::tworavens::dataverse_fqdn}:${iqss::tworavens::dataverse_port}';",
      match   => 'hostname="dataverse-demo.iq.harvard.edu"';
    'app_ddi production_dataverse_url':
      ensure  => present,
      path    => "${iqss::tworavens::dataexplore_dir}/app_ddi.js",
      line    => "dataverseurl='${iqss::tworavens::dataverse_site_url}';",
      match   => 'PRODUCTION_DATAVERSE_URL';
    'app_ddi rappURL':
      ensure  => present,
      path    => "${iqss::tworavens::dataexplore_dir}/app_ddi.js",
      line    => "var rappURL = '${iqss::tworavens::protocol}://${iqss::tworavens::domain}:${iqss::tworavens::port}/custom/';",
      match   => 'var rappURL = "https://dataverse-demo.iq.harvard.edu/custom/"';
  }

}