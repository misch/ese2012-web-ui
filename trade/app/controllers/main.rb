def relative(path)
  File.join(File.expand_path(File.dirname(__FILE__)), path)
end
Views = relative('../views')
require 'rubygems'
require 'require_relative'
require 'sinatra/base'

#require_relative('controllers/init.rb')
#require_relative('../fixture.rb')

class Main < Sinatra::Base
  enable :sessions
  set :views, Views
#  use Controllers::Authentication
#  use Controllers::TextController

  get("/") { haml :hello }
end

Main.run!


