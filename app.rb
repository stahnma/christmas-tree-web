
require 'rubygems'
require 'sinatra'
require 'erb'

#--------------------------------------------------------------
#  You may need to modify the Address of your X10 Transceiver.
ADDRESS = 'A1'
#--------------------------------------------------------------

get '/' do
    @address = ADDRESS
  if request.user_agent =~ /ipad|ipod|android/i
    erb :index
  else
    erb :desktop
  end
end

get "/#{ADDRESS}/on" do
  %x{sudo heyu fon #{ADDRESS}}
  @address = ADDRESS
  erb :on
end

get "/#{ADDRESS}/off" do
  %x{sudo heyu foff #{ADDRESS}}
  @address = ADDRESS
  erb :off
end

#TODO probably some more error handling
