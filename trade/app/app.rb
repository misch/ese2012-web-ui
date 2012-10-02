def relative(path)
  File.join(File.expand_path(File.dirname(__FILE__)), path)
end

require 'rubygems'
require 'sinatra'
require 'require_relative'
require '../app/models/user'
require 'controllers/main'
require 'controllers/authentication'
require 'haml'

    include Controllers
class App < Sinatra::Base
  set :public_folder, 'app/public'

  puts root

  use Main
  use Authentication

  enable :sessions

  configure :development do
    jimi = Models::User.new("Jimi",123)
    jimi.save

    jonny = Models::User.new("Jonny",321)
    jonny.save

  end
end

App.run!

