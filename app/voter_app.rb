require 'sinatra/base'

module Voter
  class App < Sinatra::Base
    get '/' do
      'hello voter'
    end
  end
end