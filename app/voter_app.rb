require 'sinatra/base'
require 'sinatra/reloader'
require 'digest/sha1'
require 'topic'
require 'option'

module Voter
  class App < Sinatra::Base
    register Sinatra::Reloader

    configure do
      # load mongoid config
      Mongoid.load!("config/mongoid.yml", :development)
      set :salt, 'ajzTWGCjGicyRaP2H5Qw7VSXb'
    end

    get '/' do
      erb :home
    end

    # topic
    get '/topic' do
      erb :add_topic
    end

    post '/topic' do
      @key = Digest::SHA1.hexdigest(@params[:name] + Time.now.to_s + settings.salt)
      topic = Topic.new(name: @params[:name], key: @key)
      option_params = @params.select {|k, v| k.start_with? 'option'}

      option_params.values.each do |option_value|
        option = Option.new(name: option_value)
        topic.options << option
      end

      topic.save!
      erb :topic_created
    end
  end
end