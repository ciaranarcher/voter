require 'spec_helper'
require 'voter'
require 'topic'
require 'digest/sha1'

module Voter
  describe Voter do
    it 'only allows a participant vote on a topic if they have the correct key' do

      # setup a topic with a specific key
      key = Digest::SHA1.hexdigest('foo' + Time.now.to_s)
      topic = Topic.new
      topic.stub(:save!).and_return true
      topic.name = 'test'
      topic.key = key
      topic.save!

      # check voting allowed by comparing key to topic
      Voter::voting_allowed?(topic, key).should be_true
    end  
  end
end