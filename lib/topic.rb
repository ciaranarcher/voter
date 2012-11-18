require 'mongoid'

module Voter
  class Topic
    include Mongoid::Document
    embeds_many :options


    field :name, type: String
    field :key, type: String
    field :created_at, type: Time, default: ->{ Time.now }
  end
end