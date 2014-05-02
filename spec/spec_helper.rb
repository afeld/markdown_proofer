$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'markdown_proofer'

def fixture_path
  File.join(File.dirname(__FILE__), 'fixtures')
end
