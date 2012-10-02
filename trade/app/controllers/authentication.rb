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

  class Authentication < Sinatra::Application
    set :views, Views

    get "/login" do
      haml :login
    end

    get '/logout' do
      session[:name] = nil
      redirect '/login'
    end

    post '/login' do
      name = params[:username]
      password = params[:password]

      user = User.by_name(name)
      if user == nil
        "User not found."
      else
        if user.authenticate?(password)
          session[:name] = name
          redirect '/home'
        else
          "The password was wrong."
        end
      end
    end

    post '/logout' do
      session[:name] = nil
      redirect '/'
    end
  end
end



