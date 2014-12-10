# Use hiera as a lightweight ENC.
node default {
  hiera_include('classes')
}

Exec {
  path => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
}
