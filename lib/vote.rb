require 'mongoid'

module Voter
  class Vote
    include Mongoid::Document

    field :created_at, type: Time, default: ->{ Time.now }
  end
end