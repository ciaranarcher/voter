require 'sinatra/base'
require 'sinatra/reloader'
require 'digest/sha1'
require 'officer'

module Voter
  class App < Sinatra::Base
    configure :development do
      register Sinatra::Reloader
    end

    configure do
      # load mongoid config
      Mongoid.load!("config/mongoid.yml", :development)
      set :salt, 'ajzTWGCjGicyRaP2H5Qw7VSXb'
    end

    get '/' do
      erb :home
    end

    # topic
    get '/topic/all' do
      "#{Topic.count.to_s} topics have been created."
    end

    post '/topic/find' do
      # find the topic by key
      topic = Officer::find_topic_by_key @params[:key]
      if topic.exists?
        @topic = topic.first
        @options = @topic.options
        erb :vote_on_topic
      else
        erb :topic_not_found
      end
    end

    get '/topic' do
      erb :add_topic
    end

    post '/topic' do
      option_params = @params.select {|k, v| k.start_with? 'option'}
      @key = Officer::create_topic(@params[:name], option_params, settings.salt)

      erb :topic_created
    end
  end
end