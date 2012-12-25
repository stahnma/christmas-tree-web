require 'sinatra'
require 'rack'

require File.join(File.dirname(__FILE__), 'ChristmasTree')
disable :run


map '/xmas' do
  run ChristmasTree.new
end

# Handle missing slashes with a reverse proxy
map '/' do
  run Proc.new { |ENV|  [ 302, {'Location'=> "#{ENV['rack.url_scheme']}://#{ENV['HTTP_HOST']}/xmas/" }, [] ] }
end
