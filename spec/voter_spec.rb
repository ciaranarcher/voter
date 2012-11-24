require 'spec_helper'
require 'voter'
require 'topic'
require 'digest/sha1'

module Voter
  describe Voter do

    describe 'voting' do
      before(:each) do
        # setup a topic with a specific key
        @key = Digest::SHA1.hexdigest('foo' + Time.now.to_s)
        @topic = Topic.new
        @topic.stub(:save!).and_return true
        @topic.name = 'test'
        @topic.key = @key

        o1 = Option.new
        o1.stub(:save!).and_return true
        o1.name = 'red'
        o1.save!

        o2 = Option.new
        o2.stub(:save!).and_return true
        o2.name = 'blue'
        o2.save!

        # add to topic options
        @topic.options << o1 << o2
        @topic.save!
      end
      
      it 'only allows a participant vote on a topic if they have the correct key' do
        # check voting allowed by comparing key to topic
        Voter::voting_allowed?(@topic, @key).should be_true
      end

      it 'allows a vote to be made on a topic' do
        Voter::vote!(@topic, 'red').should be_true
      end

      pending 'only allows a participant to vote once on a topic' do
      end
    end

    
  end
end