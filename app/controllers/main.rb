def relative(path)
  File.join(File.expand_path(File.dirname(__FILE__)), path)
end


Views = relative('../views')
require 'rubygems'
require 'require_relative'
require 'sinatra'
require_relative('../models/user')
require_relative('../models/item')

include Models

module Controllers

  class Main < Sinatra::Application
    set :views, Views

    before do
      redirect "/login" unless session[:name]
    end

    get "/" do
      redirect "/home"
    end

    get "/home" do
      current_user = User.by_name(session[:name])
      users = User.all.select {|user| !user.eql?(current_user)}
      haml :home, :locals => {:users => users, :user => current_user}
    end

    get "/:name" do
      name = params[:name]
      user = User.by_name(name)
      haml :item_list, :locals => {:user => user, :active_items => user.list_active_items, :inactive_items => user.items.select{|item| !item.active?}}
    end

    post "/buy" do
      buyer = User.by_name(session[:name])
      seller = User.by_name(params[:seller])
      item = seller.items.detect {|item| item.name.eql?(params[:item])}

      if buyer.buy_item(seller,item)
        redirect "/home"
      else
        fail "#{buyer.name}, you cannot buy this item!"
      end
    end
  end
end



