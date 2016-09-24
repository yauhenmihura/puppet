# manifests/init.pp:

class exit {
  if $::is_puppetmaster {
    include 'exit::master'
  }
    else {
      include 'exit::node'
    }
}
