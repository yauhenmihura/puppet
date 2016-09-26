# manifests/node.pp

class exit::node {

# Add master dns to puppet server
  host { 'master.mihura.com':
    ip           => '192.168.33.14',
    host_aliases => 'master',
  }

# Change puppet.conf with puppet server variable
  file { '/etc/puppetlabs/puppet/puppet.conf':
    require => Package['puppet-agent.x86_64'],
    content => template('/vagrant/exit/templates/node/puppet.conf.erb'),
    owner   => root,
    group   => root,
    mode    => '0644'
  }

# Run puppet agent
  service { 'puppet':
    require => File['/etc/puppetlabs/puppet/puppet.conf'],
    ensure => 'running',
    enable => true,
  }
}

