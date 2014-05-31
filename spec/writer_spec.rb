require 'spec_helper'

describe VhostWriter::Writer do
  subject(:writer) { VhostWriter::Writer.new :sites_dir => 'spec/test/www/', :conf_dir => 'spec/test/sites-available'}
  let(:template) { File.read 'spec/test/templates/template.erb' }
  let(:all_sites) { ['example.com', 'example.org', 'foo.example.com'] }

  describe '#initialize' do
    it 'should return a writer object' do
      expect(writer).to be_an_instance_of VhostWriter::Writer
    end

    it 'requires a :conf_dir parameter' do
      expect { VhostWriter::Writer.new :sites_dir => 'foo/bar' }.to raise_error ':conf_dir is required'
    end

    it 'requires either :sites_dir or :sites' do
      expect { VhostWriter::Writer.new :conf_dir => 'foo/bar' }.to raise_error 'Either :sites_dir or :sites is required'
    end

    it 'should not accept both :sites_dir and :sites' do
      expect { VhostWriter::Writer.new :conf_dir => 'foo/bar', :sites_dir => 'bar/baz', :sites => ['example.com', 'example.org']}.to raise_error 'Only one of :sites_dir and :sites is allowed'
    end

    context 'when conf_dir does not have a trailing slash' do
      it 'should automatically add a trailing slash' do
        expect(writer.conf_dir).to eql 'spec/test/sites-available/'
      end
    end
  end

  describe '#sites' do
    it 'should reflect the sites in the sites directory' do
      expect(writer.sites).to eql all_sites
    end
  end

  describe '#blacklist' do
    let(:blacklisted_writer) { writer.blacklist ['example.com'] }

    it 'should return a writer object' do
      expect(blacklisted_writer).to be_an_instance_of VhostWriter::Writer
    end

    it 'should ignore blacklisted sites' do
      expect(blacklisted_writer.sites).to eql ['example.org', 'foo.example.com']
    end
  end

  describe '#whitelist' do
    let(:whitelisted_writer) { writer.whitelist ['example.com'] }

    it 'should return a writer object' do
      expect(whitelisted_writer).to be_an_instance_of VhostWriter::Writer
    end

    it 'should only operate on whitelisted sites' do
      expect(whitelisted_writer.sites).to eql ['example.com']
    end
  end

  describe '#write_configs!' do
    before { writer.write_configs! template }
    let(:results_dir_contents) { Dir.glob('spec/test/sites-available/*').map { |f| File.basename f } }

    it 'should write config files' do
      expect(results_dir_contents).to eql all_sites
    end

    it 'should utilize the provided template' do
      expect(File.read 'spec/test/sites-available/example.com').to eql File.read 'spec/test/expected/example.com'
    end

    after { Dir.glob('spec/test/sites-available/*').each { |f| File.delete f } }
  end
end
