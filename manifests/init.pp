# manifests/init.pp:

if $::hostname == 'node1' {

  exec { 'master_dns':
    command =>
      'if ! grep master.mihura.com /etc/hosts ; then
        echo "192.168.33.14 master.mihura.com master" >> /etc/hosts
      fi',
    provider => shell,
  }
 
  package { 'puppet-agent':
    ensure => 'latest',
  }

  exec { 'master_server':
    command =>
      'if ! grep master.mihura.com /etc/puppetlabs/puppet/puppet.conf; then
        echo "server =  master.mihura.com" >> /etc/puppetlabs/puppet/puppet.conf
      fi',
    provider => shell,
  }

  service { 'puppet':
    ensure => 'running',
    enable => 'true',
  }
}

elsif $::hostname == 'master' {

  exec { 'node1_dns':
    command =>
      'if ! grep node1.mihura.com /etc/hosts ; then
        echo "192.168.33.13 node1.mihura.com node1" >> /etc/hosts
      fi',
    provider => shell,
  }

  package { 'puppetserver':
    ensure => 'latest',
  }

  exec { 'domain_autosign':
    command =>
      'if ! grep *.mihura.com /etc/hosts ; then
        echo "*.mihura.com" >> /etc/puppetlabs/puppet/autosign.conf
      fi',
    provider => shell,
  }

  service { 'puppetserver': 
    ensure => 'running',
  }
}
