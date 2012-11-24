require 'mongoid'

module Voter
  class Participant
    include Mongoid::Document

    field :name, type: String
    field :email, type: String
    field :created_at, type: Time, default: ->{ Time.now }
  end
end