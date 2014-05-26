require 'spec_helper'
require 'vhost_writer/cli'

describe VhostWriter::CLI do
  describe '#write' do
    context 'when given parameters' do
      before { subject.write 'spec/test/www/', 'spec/test/sites-available/', 'spec/test/templates/template.erb' }

      it 'should write config files' do
        expect(Dir.glob('spec/test/sites-available/*').map { |f| File.basename f }).to eql ['example.com', 'example.org', 'foo.example.com']
      end

      it 'should utilize the specified template' do
        expect(File.read 'spec/test/sites-available/example.com').to eql File.read 'spec/test/expected/example.com'
      end

      after { Dir.glob('spec/test/sites-available/*').each { |f| File.delete f } }
    end

    context 'when given a config file' do
      pending 'not yet implemented'
    end
  end
end