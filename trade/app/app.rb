def relative(path)
  File.join(File.expand_path(File.dirname(__FILE__)), path)
end

require 'rubygems'
require 'sinatra'
require 'require_relative'
require_relative('../app/models/user')
require_relative('controllers/main')
require_relative('controllers/authentication')
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
    jimi.add_new_item_to_system("Guitar", 50)
    jimi.add_new_item_to_system("Pick", 2)
    jimi.add_new_item_to_system("VW bus",500)
    jimi.add_new_item_to_system("Drugs",200)
    jimi.activate_items

    johnny = Models::User.new("Johnny","johnny")
    johnny.add_new_item_to_system("Doughnuts",3)
    johnny.add_new_item_to_system("Cookies",7)
    johnny.add_new_item_to_system("Asian bird nest",55)
    johnny.add_new_item_to_system("Ben & Jerry's",20)
    johnny.activate_items

    ese = Models::User.new("ese","ese")
    ese.add_new_item_to_system("Golden nothing",120)
    ese.activate_items

    jimi.save
    johnny.save
    ese.save
  end
end

App.run!

