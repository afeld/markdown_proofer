$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'markdown_proofer'

Bundler.require(:default, :development)

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :typhoeus
  c.configure_rspec_metadata!
end


def vcr_options
  { :cassette_name => 'all', :record => :new_episodes }
end

def fixture_path(file='')
  File.join(File.dirname(__FILE__), 'fixtures', file)
end
