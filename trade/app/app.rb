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
#  set :public_folder, 'app/public'

  puts root

  use Authentication
  use Main


  enable :sessions

  configure :development do
    jimi = Models::User.new("Jimi", "jimi")
    jimi.add_new_item_to_system("guitar", 50)
    jimi.add_new_item_to_system("pick", 2)
    items = jimi.items
    items[0].state = 'active'
    jimi.save

    johnny = Models::User.new("Johnny","johnny")
    johnny.save

    ese = Models::User.new("ese","ese")
    ese.save

  end
end

App.run!

