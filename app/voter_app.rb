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
      @participant_name = @params[:participant_name]
      @participant_email = @params[:participant_email]

      # find the topic by key
      @topic = Officer::find_topic_by_key @params[:key]
      unless @topic.nil?
        @vote_options = @topic.vote_options
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

    post '/vote' do
      participant = Officer::find_or_create_participant(
        @params[:participant_email], @params[:participant_name]
      )

      topic = Officer::find_topic_by_key @params[:topic_key]

      begin
        if Officer::vote!(topic, participant, @params[:option])
          p 'vote registered'
        else
          p 'error voting'
        end
      rescue => ex
        p ex.to_s
        p "exception making vote #{ex}"
      end
    end
  end
end