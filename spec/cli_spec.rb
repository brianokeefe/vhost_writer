require 'spec_helper'
require 'vhost_writer/cli'

describe VhostWriter::CLI do
  describe '#write' do
    context 'when given parameters' do
      before { subject.write 'spec/test/www/', 'spec/test/sites-available/', 'spec/test/templates/template.erb' }

      it 'should write config files' do
        expect(Dir.glob('spec/test/sites-available/*').map { |f| File.basename f }.sort).to eql ['example.com', 'example.org', 'foo.example.com']
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

  describe '#scaffold' do
    context 'when a valid scaffold is specified' do
      let(:scaffold_contents) { File.read 'lib/vhost_writer/scaffolds/apache.erb' }
      before do
        Dir.chdir('spec/test') { subject.scaffold 'apache' }
      end

      it 'should generate a file' do
        expect(Dir.glob('spec/test/*').map { |f| File.basename f }).to include 'apache.erb'
      end

      it 'the file should be copied from the scaffold' do
        expect(File.read 'spec/test/apache.erb').to eql scaffold_contents
      end

      after { File.delete 'spec/test/apache.erb' }
    end

    context 'when an invalid scaffold is specified' do
      let(:output) { capture(:stdout) { subject.scaffold 'not-real' } }

      it 'should return an error message' do
        expect(output).to include 'Specified scaffold does not exist'
      end
    end

    context 'when no scaffold is specified' do
      let(:output) { capture(:stdout) { subject.scaffold } }

      it 'should list the available scaffolds' do
        expect(output).to include 'apache'
      end
    end
  end
end