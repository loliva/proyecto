class newrelic ($tsenv = "DEV") {

  if ($tsenv == "DEV") {
    $license_key = ""
  }

  if ($tsenv == "QA") {
    $license_key = "35be669418e6e725f9494df9da0ba5f9858f277c"
  }

  if ($tsenv == "PROD") {
    $license_key = "f463377a2e4438fdf0461d791c7c56ef5142ba8b"
  }

  # instalar newrelic
  package { "newrelic-repo":
    ensure   => present,
    source   => "http://download.newrelic.com/pub/newrelic/el5/i386/newrelic-repo-5-3.noarch.rpm",
    provider => rpm,
  }

  package { "newrelic-sysmond":
    ensure  => present,
    require => Package["newrelic-repo"],
  }

  exec { 'config_newrelic':
    # ejecuta config + id
    command => "/usr/sbin/nrsysmond-config --set license_key=${license_key}; /bin/touch /etc/newrelicApplied",
    require => Package["newrelic-sysmond"],
    notify  => Service['newrelic-sysmond'],
    creates => '/etc/newrelicApplied',
  }

  service { 'newrelic-sysmond':
    # inicia servicio
    ensure  => running,
    enable  => true,
    require => Exec['config_newrelic'],
  }

}
