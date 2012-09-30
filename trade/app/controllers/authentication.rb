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

  class Authentication < Sinatra::Application
    set :views, Views

    get "/login" do
      haml :login
    end
  end
end
