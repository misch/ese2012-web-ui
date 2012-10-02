def relative(path)
  File.join(File.expand_path(File.dirname(__FILE__)), path)
end


Views = relative('../views')
require 'rubygems'
require 'require_relative'
require 'sinatra'
require_relative('../models/user')
require_relative('../models/item')
#require_relative('../app')

include Models

module Controllers

class Main < Sinatra::Application
  set :views, Views

  User.new("Misch", 124).save
  User.new("Mei Ling", 456).save
  # How can we get that to do somewhere else? Didn't manage to get it working by now.

  get "/" do
    haml :home
  end


  # should be managed by authentication controller

   get "/users" do
    haml :list, :locals => {:users => Models::User.all}
  end



end
end



