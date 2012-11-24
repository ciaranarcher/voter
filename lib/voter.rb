module Voter
  class Voter
    def self.voting_allowed?(topic, key)
      return true if topic.key == key
      false
    end

    def self.vote!(topic, option)
      raise VotingOptionNotFound if topic.options.select {|o| o.name == option}.empty?
    end
  end
end