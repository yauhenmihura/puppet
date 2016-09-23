# /init.pp:

if $::hostname == 'node1' {

  host { 'master.mihura.com':
    ip           => '192.168.33.14',
    host_aliases => 'master',
  }

  file { '/etc/puppetlabs/puppet/puppet.conf':
    content => template('/vagrant/templates/node/puppet.conf.erb'),
    owner   => root,
    group   => root,
    mode => '0644'
   }

  service { 'puppet':
    ensure => 'running',
    enable => 'true',
  }
}

elsif $::hostname == 'master' {

  host { 'node1.mihura.com':
    ip           => '192.168.33.13',
    host_aliases => 'node1',
  }

  package { 'puppetserver':
    ensure => 'latest',
  }

  file { '/etc/puppetlabs/puppet/autosign.conf':
    content => template('/vagrant/templates/master/autosign.conf.erb'),
    owner   => root,
    group   => root,
    mode => '0644'
   }

  service { 'puppetserver': 
    ensure => 'running',
  }
}
