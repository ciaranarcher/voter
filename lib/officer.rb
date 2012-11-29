require 'topic'

module Voter
  class Officer
    def self.voting_allowed?(topic, key)
      return true if topic.key == key
      false
    end

    def self.vote!(topic, participant, option)
      # check for option existing
      option = topic.options.select {|o| o.name == option}.first
      raise 'voting option not found' if option.nil?

      # check for the participant having voted on any option in this topic
      topic.options.each do |opt|
        unless opt.votes.select {|v| v.participant_email == participant.email}.empty?
          raise 'participant has voted on topic before'
        end 
      end

      # looks good, so add the vote to the option
      vote = Vote.new(participant_email: participant.email)
      option.votes << vote 
      option.save! 

      true
    end

    def self.report_ranked_desc(topic)
      topic.options.sort do |a, b| 
        b.votes.length <=> a.votes.length 
      end
    end

    def self.find_topic_by_key(key)
      Topic.where(key: key)
    end
  end
end