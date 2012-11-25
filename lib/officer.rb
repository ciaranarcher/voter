module Voter
  class Voter
    def self.voting_allowed?(topic, key)
      return true if topic.key == key
      false
    end

    def self.vote!(topic, option)
      option = topic.options.select {|o| o.name == option}.first
      # check for option existing
      raise VotingOptionNotFound if option.nil?

      # looks good, so add the vote to the option
      option.votes << Vote.new
      option.save! 

      true
    end
  end
end