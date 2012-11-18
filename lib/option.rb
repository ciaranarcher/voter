require 'mongoid'

module Voter
  class Option
    include Mongoid::Document
    
    field :name, type: String
    field :vote_count, type: Integer
  end
end