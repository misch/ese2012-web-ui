def relative(path)
  File.join(File.expand_path(File.dirname(__FILE__)), path)
end

require 'rubygems'
require 'sinatra'
require 'require_relative'
require '../app/models/user'
require '../app/controllers/main'
require '../app/controllers/authentication'
require '../app/app'
require 'haml'


class App < Sinatra::Application
  use Controllers::Main
  use Controllers::Authentication
#  use Controllers::Main

  enable :sessions

  #set :public_folder, 'app/public'

  configure :development do
    jimi = Models::User.new("Jimi")
    jimi.save

    jonny = Models::User.new("Jonny")
    jonny.save
  end
end

App.run!

