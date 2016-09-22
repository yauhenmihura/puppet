# /init.pp:

if ${hostname} == 'node1' {

   exec { "master_ip":
     command =>
       'if ! grep master.mihura.com /etc/hosts ; then
          echo "192.168.33.14 master.mihura.com master" >> /etc/hosts
       fi',
   }
 
   package { 'puppet-agent':
     ensure => 'latest',
   }

   service { 'puppet':
     ensure => 'running',
     enable => 'true',
   }
}
#                                   #  exec { "master_ip":
#                                   #    command => 'echo "master.mihura.com master" >> /etc/hosts',
#                                   #    onlyif  => "grep "192.168.33.14 master.mihura.com" /etc/hosts",
#                                   #  }
#
