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

    get '/topic' do
      if @params.has_key? 'key'
        # find the topic by key, error if not existing
        topic = Officer::find_topic_by_key @params[:key]
        if topic.exists?
          @topic = topic.first
          @options = @topic.options
          erb :vote_on_topic
        else
          erb :topic_not_found
        end
      else
        erb :add_topic
      end
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