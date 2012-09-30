require 'rubygems'
require 'sinatra'
require 'require_relative'
require_relative('models/user')
require_relative('models/item')
require_relative('controllers/main')
require 'haml'

include Models

class App < Sinatra::Base
  enable :sessions

  #set :public_folder, 'app/public'

  configure :development do
    jimi = User.new("Jimi")
    jimi.save

    jonny = User.new("Jonny")
    jonny.save
  end
end

App.run!

