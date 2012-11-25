require 'mongoid'

module Voter
  class Vote
    include Mongoid::Document

    field :participant_email, type: String
    field :created_at, type: Time, default: ->{ Time.now }
  end
end