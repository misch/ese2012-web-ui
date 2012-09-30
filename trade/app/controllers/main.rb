require 'rubygems'
require 'sinatra'
require 'haml'

module Controllers

  class Main < Sinatra::Application
    get '/' do
      haml :hello
    end
  end
end


