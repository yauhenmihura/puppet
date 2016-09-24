# manifests/master.pp:

class exit::master {

# Add node dns to hosts
  host { 'node1.mihura.com':
    ip           => '192.168.33.13',
    host_aliases => 'node1',
  }

# Install puppet server
  package { 'puppetserver':
    ensure => '2.6.0-1.el7',
  }

# Change autosign.conf with entry "*.mihura.com"
  file { '/etc/puppetlabs/puppet/autosign.conf':
    content => template('/vagrant/exit/templates/master/autosign.conf.erb'),
    owner   => root,
    group   => root,
    mode => '0644'
   }

# Start puppet server
  service { 'puppetserver':
    ensure => 'running',
  }
}
