
require 'rubygems' if RUBY_VERSION < "1.9"
require 'sinatra'
require 'sinatra/base'
require 'erb'

#--------------------------------------------------------------
#  You may need to modify the Address of your X10 Transceiver.
ADDRESS = 'A1'
#--------------------------------------------------------------

class ChristmasTree < Sinatra::Base

  set :environment, :production
  set :logging
  set :root, File.dirname(__FILE__)
  set :public_folder, File.dirname(__FILE__)+ '/public'

  get '/' do
      @address = ADDRESS
      puts "Current directory is #{%x{pwd}}"
    if request.user_agent =~ /ipad|ipod|android/i
      erb :index
    else
      erb :desktop
    end
  end

  get "/#{ADDRESS}/on" do
    %x{bash -c "sudo heyu fon #{ADDRESS}"}
    @address = ADDRESS
    erb :on
  end

  get "/#{ADDRESS}/off" do
    %x{bash -c "sudo heyu foff #{ADDRESS}"}
    @address = ADDRESS
    erb :off
  end

  #TODO probably some more error handling
end

# Used only when testing
#ChristmasTree.run!
