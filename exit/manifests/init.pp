# manifests/init.pp:

class exit {
  notify { "$::hostname": }
  notify { "$::is_puppetmaster": }

  if $::is_puppetmaster {
    include exit::master
  } 
  else {
    include exit::node
  }
}
