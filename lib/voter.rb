module Voter
  class Voter
    def self.voting_allowed?(topic, key)
      return true if topic.key == key
      false
    end
  end
end