def relative(path)
  File.join(File.expand_path(File.dirname(__FILE__)), path)
end

Views = relative('../views')

require 'rubygems'
require 'require_relative'
require 'sinatra'
require_relative('../models/user')
require_relative('../models/item')
require_relative('../app')



module Controllers

class Main < Sinatra::Application
  enable :sessions
  set :views, Views
  #use Controllers::Authentication
  #use Controllers::List

  get "/" do
    haml :index, :locals => {:users => Models::User.all}
  end
end
Main.run!
end



