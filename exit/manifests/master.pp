# manifests/master.pp:

class exit::master($serv_version = '2.6.0-1.el7') {

# Add node dns to hosts
  host { 'node1.mihura.com':
    ip           => '192.168.33.13',
    host_aliases => 'node1',
  }

# Install puppet server
  package { 'puppetserver':
    require => Package['puppet-agent.x86_64'],
    ensure => $serv_version,
  }

# Change autosign.conf with entry "*.mihura.com"
  file { '/etc/puppetlabs/puppet/autosign.conf':
    content => template('/vagrant/exit/templates/master/autosign.conf.erb'),
    owner   => root,
    group   => root,
    mode    => '0644'
  }

# Start puppet server
  service { 'puppetserver':
    require => File['/etc/puppetlabs/puppet/autosign.conf'],
    ensure => 'running',
  }
}
