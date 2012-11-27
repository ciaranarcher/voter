require 'sinatra/base'
require 'sinatra/reloader'

module Voter
  class App < Sinatra::Base
    register Sinatra::Reloader

    get '/' do
      erb :home
    end
  end
end