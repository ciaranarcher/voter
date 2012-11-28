require 'sinatra/base'
require 'sinatra/reloader'

module Voter
  class App < Sinatra::Base
    register Sinatra::Reloader

    get '/' do
      erb :home
    end

    # topic
    get '/topic' do
      erb :add_topic
    end

    post '/topic' do

      
    end
  end
end