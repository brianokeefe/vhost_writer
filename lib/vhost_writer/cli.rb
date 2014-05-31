require 'thor'
require 'vhost_writer'

module VhostWriter
  class CLI < Thor
    include Thor::Actions

    source_root "#{File.dirname __FILE__}/scaffolds/"

    desc 'write [SITES_DIR] [CONF_DIR] [TEMPLATE]',
    'Use the site directories in SITES_DIRECTORY to generate vhost configs in
CONFIG_DIRECTORY using TEMPLATE'
    def write(sites_dir, conf_dir, template)
      writer = VhostWriter::Writer.new :sites_dir => sites_dir, :conf_dir => conf_dir
      writer.write_configs! File.read template
    end

    desc 'scaffold [WEB_SERVER]',
    'Generate a default template for WEB_SERVER. Run without arguments for a
list of supported web servers.'
    def scaffold(scaffold='')
      if scaffold.empty?
        say "Supported scaffolds:\n  ", :yellow
        say "#{supported_scaffolds.join("\n  ")}"
      else
        write_scaffold scaffold
      end
    end

    private
    def supported_scaffolds
      Dir.glob("#{source_paths.first}*").map { |f| File.basename f, '.erb' }
    end

    def write_scaffold(scaffold)
      if supported_scaffolds.include? scaffold
        copy_file "#{scaffold}.erb"
      else
        say "Specified scaffold does not exist", :red
      end
    end
  end
end
