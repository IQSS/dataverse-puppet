Dataverse puppet module
=======================

Table of Contents
-----------------

1. [Overview - What is the Dataverse module?](#overview)
2. [License](#license)
3. [Version numbering](#version-numbering)
4. [Module Description - What does the module do?](#module-description)
5. [Dataverse releases](#dataverse-releases)
6. [Setup - The basics of getting started with Dataverse module](#setup)
7. [Before you begin - Pre setup conditions](#before-you-begin)
8. [Configuring the infrastructure - Installing dataverse](#configuring-your-infrastructure)
9. [Public Classes and Defined Types](#public-classes-and-defined-types)
10. [Private Classes and Defined Types](#private-classes-and-defined-types)
11. [Examples](#examples)
12. [Known issues](#known-issues)
13. [To do](#todo)
14. [Contributors](#contributors)

Overview
--------

The Dataverse module allows you to install Dataverse with Puppet.

License
-------

GPLv3 - Copyright (C) 2015-2016 International Institute of Social History <socialhistory.org>.

Version numbering
------------------

This module's branch versions and tags reflect the API's status as meant by [Semantic Versioning](http://semver.org/).
The API contract is specified in the [Classes and Defined Types](#classes-and-defined-types) section.

Module Description
-------------------

Dataverse is an [open sourced](https://github.com/IQSS/dataverse) web application to share, preserve, cite, explore and
analyze research data. It facilitates making data available to others, and allows you to replicate others work.
Researchers, data authors, publishers, data distributors, and affiliated institutions all receive appropriate credit via
a data citation with a persistent identifier (e.g., DOI, or Handle).The module offers support for basic management of
common security settings.

This module will install dataverse with default settings and allow customisation of those settings.

Dataverse releases
------------------

It is likely that Dataverse will continue releasing new packages with new installation features.
That does not mean the version of this module is not compatible with such releases. It is just
that you may have to manually apply [configurations or patches](https://github.com/IQSS/dataverse/releases) that this
module does not know about at the time of this release.
     
Setup
-----

**What this Dataverse setup affects:**

* Packages/service/configuration files for Dataverse, R and R packages, PostgreSQL, Solr and TwoRavens.

**What this Dataverse setup does not affect:**

* Optimizations such as the best settings for Glassfish and PostgreSQL.
* Shibboleth configurations (as they have an experimental status), although the packages are installed.

Before you begin
----------------

* take a look at the known issues
* unzip must be installed on the OS.
* The solr installation does not provision java. Install the latter when you apply this class without Dataverse::Dataverse 
* Import the SQL statements in reference_data.sql if you install the database on a different machine than Dataverse::Dataverse.
* Apply a first-time update of each of the host's package repository using 'apt-get update' or 'yum update'.
* Maybe take a look at the [examples](example) if you are unfamiliar with puppet or need some suggestions.

Configuring your infrastructure
-------------------------------

To install Dataverse and TwoRavens with all the out-of-the-box settings use:

    class {
      'dataverse::java':      # Java if the host has not got 1.8 already.
    }

    class {
      'dataverse::solr':      # Solr
        require => Class['dataverse::java'],
    }

    class {
      'dataverse::database':  # Our database
    }

    class {
      'dataverse::rserve':    # RServe
    }

    class {
      'dataverse::dataverse': # Dataverse
        require => Class['dataverse::database', 'dataverse::java'],
    }

    class {
      'dataverse::tworavens': # TwoRavens add-on
    }
    
To install on different machines you can deploy per server per component. E.g.:

    database-0.domain.org     class { 'dataverse::database': }
    dataverse-1.domain.org    class { 'dataverse::dataverse': }
    dataverse-2.domain.org    class { 'dataverse::dataverse': }
    dataverse-3.domain.org    class { 'dataverse::dataverse': }
    rserve-0.domain.org       class { 'dataverse::rserve': }
    solr-0.domain.org         class { 'dataverse::solr': }
    tworavens-0.domain.org    class { 'dataverse::tworavens': }
    
###Public Classes and Defined Types

Public classes can be set when declaring them in a manifest and with (#hieradata).

This module modifies configuration files and directories with the following public classes:

* [Class: Dataverse::Database](#class-dataverse::database)
* [Class: Dataverse::Dataverse](#class-dataverse::dataverse)
* [Class: Dataverse::Java](#class-dataverse::java)
* [Class: Dataverse::Rserve](#class-dataverse::rserve)
* [Class: Dataverse::Solr](#class-dataverse::solr)
* [Class: Dataverse::TwoRavens](#class-dataverse::tworavens)

####Class: Dataverse::Database

Installs Postgresql, the database user and database. For example:

    class {
      'dataverse::database':
        name     => 'dataverse',
        user     => 'dataverse',
        password => 'secret',
    }
    
It also contains settings for
   
#####`createdb=false`
   
The user can create database.

#####`createrole=false`

The user can create roles.
 
#####`encoding='UTF-8'`

This will set the default encoding encoding for all databases created with this module. On certain operating systems
this will be used during the `template1` initialization as well so it becomes a default outside of the module too.
Defaults to 'UTF-8'.

#####`hba_rule`
 
The access rules that determine who can connect to what database from where. Defaults to:

    IPv4 local connections => {
        description => 'Open up a IP4 connection from localhost',
        type        => 'host',
        database    => 'dvndb',
        user        => 'dvnApp',
        address     => '127.0.0.1/32',
        auth_method => 'md5'
        },
    IPv6 local connections => {
        description => 'Open up a IP6 connection from localhost',
        type        => 'host',
        database    => 'dvndb',
        user        => 'dvnApp',
        address     => '::1/128',
        auth_method => 'md5'
        }

#####`listen_addresses='*'`

The defaults `*` means the postgres server will accept connections accept connections from any remote
machine. Alternately, you can specify a comma-separated list of hostnames or IP addresses. (For more info, have a look
at the `postgresql.conf` file from your system's postgres package).

#####`locale='en_US.UTF-8'`

This will set the default database locale for all databases created with this module.

#####`login-true`

The fact the user can login or not.

#####`manage_package_repo=true`

Setup the official PostgreSQL repositories on your host.

#####`replication=false`

This role can replicate.

#####`superuser=false`

This role is a superuser.

#####`version='9.3'`

The version of the PostgreSQL package.

####Class: Dataverse::Dataverse

This class installs Glassfish, the domain settings and depending on the configuration builds a war or pulls a war
distribution from a repository. Example:

    class {
        'dataverse::dataverse':
            package => 'dataverse-4.2.4',
            repository => 'https://github.com/IQSS/dataverse/releases/download/v4.2.4/dataverse-4.2.4.war', 
    }
    
This will create three services:

* The Dataverse 4.2.4 distribution plus glassfish service: $ service glassfish start|stop|status
* An R-daemon: $ service rserve start|stop|status
* The Apache web server

It also contains settings for

#####`auth_password_reset_timeout_in_minutes=60`

The time in minutes for a password reset.

#####`allow_http=false`

Allow a http connection. If false, redirect traffic to https. Set to true for a development server or when you use
a proxy for SSL termination.

#####`database_dbname='dvndb'`

The name of the database.

#####`database_host='localhost'`

The resolvable hostname of the database.

#####`database_password='dvnAppPass'`  

The database user's password

#####`database_port=5432`

The database port.

#####`database_user='dvnApp'`

The username granted control over the database.

#####`doi_baseurlstring='https://ezid.cdlib.org'`

The DOI endpoint for the EZID Service.
 
#####`doi_username='apitest'`

The username to connect to the EZID Service.

#####`doi_password='apitest'`

The password to connect to the EZID Service.

#####`files_directory='/home/glassfish/dataverse/files'`

The location of the uploaded files and their tabular derivatives.

#####`fqdn='localhost'`

If the Dataverse server has multiple DNS names, this option specifies the one to be used as the "official" host name.
For example, you may want to have dataverse.foobar.edu, and not the less appealing server-123.socsci.foobar.edu to
appear exclusively in all the registered global identifiers, Data Deposit API records, etc.

Do note that whenever the system needs to form a service URL, by default, it will be formed with https:// and port 443.
I.e.,
https://{dataverse.fqdn}/

If that does not suit your setup, use the `site_url` option.

#####`glassfish_parent_dir='/home/glassfish'`

The Glassfish parent directory.

#####`glassfish_domain_name='domain1'`

The domain name.

#####`glassfish_fromaddress='do-not-reply@localhost'`

The e-mail -from field in the mail header.

#####`glassfish_jvmoption`

An array of jvm options. 

Defaults are ["-Xmx1024m", "-Djavax.xml.parsers.SAXParserFactory=com.sun.org.apache.xerces.internal.jaxp.SAXParserFactoryImpl"].

#####`glassfish_mailhost='localhost'.`

The mail relay hostname.

#####`glassfish_mailuser='dataversenotify'`

The user name that is allowed by the mail relay to sent mails.

#####`glassfish_mailproperties`

Key-value pairs sent with to the mail relay, such as credentials.

Defaults to dummy values ['username=a_username,password=a_password'].

#####`glassfish_service_name='glassfish'`

The service handle to submit start, stop, status commands. E.g. service dataverse start.

#####`glassfish_tmp_dir='/opt/glassfish'`

The download path of the glassfish package.

#####`glassfish_user='glassfish'`

The user running the glassfish domain.

#####`glassfish_version='4.1'`

The Glassfish J2EE Application server version.

#####`package='dataverse-4.4'`

The release tag: name and version of dataverse 4.

#####`port=443`

The SSL port on which dataverse can be reached.

#####`repository='https://github.com/IQSS/dataverse/releases/download/v4.4/dataverse-4.4.war'`

This indicates there the package comes from. It can be 'git' to build a war from the IQSS repository; or the repository
url of a Dataverse war file.

#####`rserve_host='localhost'`

The Rserve service endpoint.

#####`rserve_password='rserve'`

The password needed to access the Rserve service.

#####`rserve_port=6311`

The Rserve service port.

#####`rserve_user='rserve'`

The username that can access the Rserce service.
 
#####`site_url='https://localhost:443'`

The url to a dataverse web application.

####Class: Dataverse::Java

Installs Java 1.8 and sets the alternative to 1.8.

####Class: Dataverse::Rserve

Installs the Rserve or Binary R server daemon. Example:
                            
    class { 'dataverse::rserve':
        pwd  => 'potato',
    }
    
This will install R and a number of R packages including the RServe package. A password file /etc/Rserve.pwd is set with
content: rserve potato. Rserve is run by the 'rserve' user.

#####`auth='disable'`

If you need remote access use set auth 'required' and plaintext to 'disable'.

#####`chroot`

The jail directory. Defaults to undef.

#####`encoding='utf8'`

This means that strings are converted to the given encoding before being sent to the client and also all strings from
the client are assumed to come from the given encoding.

#####`eval`

Preload packages with expressions that you would otherwise have to load from scripts. Defaults to undef. 

#####`fileio='enable'`

Allow clients to perform filesystem operations via the RServe deamon.

#####`gid=97`

The group id of the 'rserve' user runnning the daemon.

#####`interactive='yes'`

Undocumented.

#####`maxinbuf=262144`

The maximum allowed buffer size in kb send from the client per connection.

#####`maxsendbuf=0`

The maximum allowed buffer size in kb send from the server per connection.

#####`plaintext='disable'`

Allows for sending credentials as plaintext.

#####`password='rserve'`

The password for connecting to the Binary R server daemon.

#####`port=6311`

The TCP port the daemon listens too.

#####`pwdfile='/etc/Rserve.pwd'`

The password file containing the authentication credentials.

#####`remote='enable'`

Allows remote connections when enabled.

#####`socket`

Undocumented. Defaults to undef.

#####`sockmod`

Undocumented. Defaults to undef.

#####`source`

Location to a file to preload packages that you would otherwise have to load from your scripts. Defaults to undef.

#####`su`

Undocumented. Defaults to undef.

#####`uid=97`

The user id of the 'rserve' user running the daemon.

#####`umask=0`

Controls how file permissions are set for files.

#####`workdir`
 
R working directory.Defaults to '/tmp/Rserv'

####Class: Dataverse::Solr

Installs Solr. Example:

    class { 'dataverse::solr':
        parent_dir => '/usr/share',
    }
    
This will create a Jetty server with a running Solr instance : $ service solr stop|status|start

It also contains settings for

#####`core='collection1'`

The handle of the Solr core.

#####`jetty_home='/home/solr/solr-4.6.0/example'`

The Jetty home directory which contains start.jar.

#####`jetty_host='localhost'`

The IP to listen to. Use 0.0.0.0 as host to listen on all IP connections.

#####`jetty_java_options`

JVM options for Jetty. 

#####`jetty_port=8983`

The port Jetty will listen to.

#####`jetty_user='solr'`

The user running the Jetty Solr instance.

#####`solr_home='/home/${jetty_user}/solr-4.6.0/example/solr'`

The Solr home used for the jvm setting -Dsolr.solr.home.

#####`url='http://archive.apache.org/dist/lucene/solr'`

The download url for solr. Preferably a mirror.

#####`version='4.6.0'`

The Apache Solr version.

####Class: Dataverse::Tworavens

This class installs the Apache RApache handler and the Tworavens web application. For example:

    class {
      'dataverse::tworavens':
        tworavens_package => 'https://github.com/IQSS/TwoRavens/archive/master.zip',
    }
    
It also contains settings for
    
#####`dataverse_fqdn='localhost'`
The public domain name of the Dataverse web application.
    
#####`dataverse_port=443`

The public port of the Dataverse web application.

#####`fqdn='localhost'`

The public domain name of the TwoRavens web application.

#####`package='https://github.com/IQSS/TwoRavens/archive/master.zip'`

The download url of TwoRavens.

#####`parent_dir='/var/www/html'`

The installation directory of the TwoRavens web application.

#####`port=443`

The public port of the TwoRavens web application.

#####`protocol='https'`

The protocol of the TwoRavens web application.

#####`rapache_version='1.2.6'`

The rapache version to be installed.

###Private Classes and Defined Types

Private classes should not be called directly from the module or manifests.
But their parameters can be altered with (#hieradata).

#### Class: Dataverse::Apache2

Installs apache.

#####`purge_configs=true`

Removes all other Apache configs and vhosts. Setting this to 'false' is a stopgap measure to allow the apache module
to coexist with existing or otherwise-managed configuration.

#### Class: Dataverse::Rpackager 

Installs R, required libraries and then a range of packages used by dataverse (RServe) and TwoRavens (Rook, Zelig, and
others).

#####`repo='http://cran.r-project.org'`

The repository to download the packages from.

#####`packages`

A list of R packages to install.

Known issues
------------

* Rserve does not start after a puppet run ( it does on boot ). You need to start the service manually after the first puppet run with
`service rserve restart`
* If you have a lower-than Java 1.8 version, the first puppet run may not be able to set the alternative to 1.8.
If this happens either rerun puppet or set the Java alternative package to 1.8 manually.
* Vagrant installations could have various issues per OS and image. If the machine does not play along, then try out the
know issues mentioned the [Vagrantfile](Vagrantfile).
* If you run Vagrant and install TwoRavens with a localhost domain, the application that runs on the client host will
not be able to reach port 443 as it will use localhost:9999 to call the dataverse API.

You may get around this last issue by setting a firewall rule in your client machine:

    $ iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 443 -j REDIRECT --to-port 9999
    $ iptables-save
    
Or create an additional VirtualHost definition for port 9999 to the Apache configuration:

    Listen 9999
    <VirtualHost *:9999>
    etc... just copy the <VirtualHost *:443> settings 
    </VirtualHost>

To do
-----

* Shibboleth

Examples
--------

See the demo installations in the example folder of this module.

Contributors
------------

* Lucien van Wouw, IISH
* Plenty room for more. Please read the [contributing guide](CONTRIBUTING.md) on how to donate.
