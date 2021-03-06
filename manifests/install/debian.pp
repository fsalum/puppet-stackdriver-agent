# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker
#
# == Class: stackdriver::install::debian
#
# Installs Stackdriver Agent for Debian derivatives
#
# === Parameters
#
# Use Hiera for overriding any parameter defaults
#
# ---
#
# [*pkg*]
# - Default - stackdriver-agent
# - DEB package name(s)
#
# [*ensure*]
# - Default - present
# - {Puppet Package Ensure Attribute}[http://docs.puppetlabs.com/references/latest/type.html#package-attribute-ensure]
#
# [*aptkey*]
# - Default: (hash)
#  {
#    'key'        => '7B190BD2',
#    'key_server' => 'subkeys.pgp.net',
#  }
# - Stackdriver APT repository authentication key
#
# [*aptsource*]
# - Default: (hash)
#  {
#    'location'  => 'http://repo.stackdriver.com/apt',
#    'release'   => $::lsbdistcodename,
#    'repos'     => 'main',
#    'key'       => '7B190BD2',
#  }
# - Stackdriver APT repository
#
class stackdriver::install::debian(

  $pkg    = 'stackdriver-agent',
  $ensure = 'present',

  $aptkey = {
    'key'         => '7B190BD2',
    'key_server'  => 'subkeys.pgp.net',
  },

  $aptsource = {
    'location'  => 'http://repo.stackdriver.com/apt',
    'release'   => $::lsbdistcodename,
    'repos'     => 'main',
    'key'       => '7B190BD2',
  },

) inherits stackdriver {

  validate_string ( $pkg        )
  validate_string ( $ensure     )
  validate_hash   ( $aptkey     )
  validate_hash   ( $aptsource  )

  # Setup repo
  ensure_resource('apt::key', 'stackdriver', $aptkey)

  Apt::Source { require => Apt::Key['stackdriver'], }

  ensure_resource('apt::source', 'stackdriver', $aptsource)

  # Install package
  ensure_resource('package', $pkg, {
    'ensure'  => $ensure,
    'require' => Apt::Source['stackdriver'],
  })

}

