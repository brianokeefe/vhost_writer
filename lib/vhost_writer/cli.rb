require 'thor'
require 'vhost_writer'

module VhostWriter
  class CLI < Thor
    desc 'write [SITES_DIR] [CONF_DIR] [TEMPLATE]',
    'Use the site directories in SITES_DIRECTORY to generate vhost configs in
    CONFIG_DIRECTORY using TEMPLATE'
    def write(sites_dir, conf_dir, template)
      writer = VhostWriter::Writer.new :sites_dir => sites_dir, :conf_dir => conf_dir
      writer.write_configs_using File.read template
    end
  end
end
