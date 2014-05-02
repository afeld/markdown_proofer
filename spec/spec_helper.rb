$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'markdown_proofer'

Bundler.require(:default, :development)

def fixture_path(file='')
  File.join(File.dirname(__FILE__), 'fixtures', file)
end
