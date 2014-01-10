# govuk_mirror-puppet

Provisions a GOV.UK mirror, using standalone Puppet (`puppet apply`).

Relies on the [govuk_mirror-deployment](https://github.gds/gds/govuk_mirror-deployment) repository.

## Development workflow

1. `bundle install`
1. `bundle exec librarian-puppet install`
1. `vagrant up`

## Requirements

- [Ruby](http://www.ruby-lang.org/) and [Bundler](http://gembundler.com/) -- ideally with [rbenv](https://github.com/sstephenson/rbenv)
- [Vagrant](http://www.vagrantup.com/) -- version >= 1.1
