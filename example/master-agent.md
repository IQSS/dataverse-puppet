Puppet master-agent setup
=========================

In the master-agent setup, all configuration and data is placed on the master Puppet server. All client nodes
have a Puppet agent that pull a manifest from the master and install the node in the desired state. This setup is
something service providers could use to manage their environments with.

For this I would like to do some more tests first. You can [track issue 4](https://github.com/IQSS/dataverse-puppet/issues/4) to see when this readme comes out.

Lucien