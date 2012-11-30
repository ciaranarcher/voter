require 'mongoid'
require 'vote_option'

module Voter
  class VoteOption
    include Mongoid::Document

    field :name, type: String
    field :created_at, type: Time, default: ->{ Time.now }

    embeds_many :votes
  end
end