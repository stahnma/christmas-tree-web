
require 'rubygems' if RUBY_VERSION < "1.9"
require 'sinatra'
require 'sinatra/base'
require 'erb'

#--------------------------------------------------------------
#  You may need to modify the Address of your X10 Transceiver.
ADDRESS = 'A1'
MOUNTED_URL='/xmas'
#--------------------------------------------------------------

class ChristmasTree < Sinatra::Base

  set :environment, :production
  set :root, File.dirname(__FILE__)
  set :public_folder, File.dirname(__FILE__)+ '/public'

  # Will log in localdir/log
  set :logging

  get '/' do
    @url = MOUNTED_URL
    @address = ADDRESS
    if request.user_agent =~ /ipad|ipod|android/i
      erb :index
    else
      erb :desktop
    end
  end

  get "/#{ADDRESS}/on" do
    %x{bash -c "heyu fon #{ADDRESS}"}
    @url = MOUNTED_URL
    @address = ADDRESS
    erb :on
  end

  get "/#{ADDRESS}/off" do
    %x{bash -c "heyu foff #{ADDRESS}"}
    @url = MOUNTED_URL
    @address = ADDRESS
    erb :off
  end

   not_found do
    redirect '/'
   end
end
