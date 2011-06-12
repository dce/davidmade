require 'rubygems'

require 'mustache'
require 'yaml'
require 'rdiscount'

require 'riot'

Dir.glob('lib/*.rb').each {|f| require f }
