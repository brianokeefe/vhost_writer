require 'erb'

module VhostWriter
  class Writer
    attr_reader :conf_dir, :sites

    def initialize(options={})
      raise ArgumentError, ':conf_dir is required' unless options.key? :conf_dir
      raise ArgumentError, 'Either :sites_dir or :sites is required' unless options.key? :sites_dir or options.key? :sites
      raise ArgumentError, 'Only one of :sites_dir and :sites is allowed' if options.key? :sites_dir and options.key? :sites

      @conf_dir = options[:conf_dir]

      if options.key? :sites_dir
        @sites = Dir.glob("#{options[:sites_dir]}*").map { |f| File.basename f }
      else
        @sites = options[:sites]
      end
    end

    def blacklist(site_blacklist)
      Writer.new :conf_dir => @conf_dir, :sites => @sites - site_blacklist
    end

    def whitelist(site_whitelist)
      Writer.new :conf_dir => @conf_dir, :sites => site_whitelist - (@sites - site_whitelist)
    end

    def write_configs!(template)
      @sites.each do |site|
        File.open(File.join(@conf_dir, site), 'w') do |f|
          f.write ERB.new(template).result(binding)
        end
      end
    end

  end
end
