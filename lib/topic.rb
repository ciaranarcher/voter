require 'mongoid'
require 'option'
require 'participant'

module Voter
  class Topic
    include Mongoid::Document
    embeds_many :options
    has_and_belongs_to_many :participants, inverse_of: nil

    field :name, type: String
    field :key, type: String
    field :created_at, type: Time, default: ->{ Time.now }
  end
end