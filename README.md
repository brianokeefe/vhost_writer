# VhostWriter
[![Gem Version](https://badge.fury.io/rb/vhost_writer.svg)](http://badge.fury.io/rb/vhost_writer)
[![Code Climate](https://codeclimate.com/github/brianokeefe/vhost_writer.png)](https://codeclimate.com/github/brianokeefe/vhost_writer)
[![Build Status](https://travis-ci.org/brianokeefe/vhost_writer.svg?branch=master)](https://travis-ci.org/brianokeefe/vhost_writer)
[![Coverage Status](https://img.shields.io/coveralls/brianokeefe/vhost_writer.svg)](https://coveralls.io/r/brianokeefe/vhost_writer?branch=master)

Automatically generate virtual host config files based on a directory of sites and a given ERB template.

## Installation

    $ gem install vhost_writer

## Usage

### Writing configs

`vhost_writer write` takes the following:

* A directory of directories that contain sites
  * Each site's directory should share the name of its domain (like `example.com`)
* A directory to write config files to
* The path to a template file written in ERB
  * Within the template, the `site` variable contains the name of the site.

#### Example

    $ vhost_writer write /srv/www/ /etc/apache2/sites-available/ /home/bok/template.erb

### Scaffolding

vhost_writer has the ability to generate sane default ERB templates for you to modify and use with `vhost_writer write`. Access this functionality with `vhost_writer scaffold`.

    # Display a list of included scaffolds
    $ vhost_writer scaffold

    # Generate an Apache ERB template
    $ vhost_writer scaffold apache

## Template Example

    <VirtualHost *:80>
      ServerAdmin admin@<%= site %>
      ServerName <%= site %>
      ServerAlias www.<%= site %>
      DocumentRoot /srv/www/<%= site %>/public_html/
      ErrorLog /srv/www/<%= site %>/logs/error.log
      CustomLog /srv/www/<%= site %>/logs/access.log combined
    </VirtualHost>

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
