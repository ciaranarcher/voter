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

      it 'raises an exception if a vote is attempted on a non-existent option' do
        lambda {Voter::vote!(@topic, 'foo')}.should raise_error
      end

      it 'allows a vote to be made on a option' do
        selected_option = 'red'
        option = @topic.options.select {|o| o.name == selected_option}
        vote_count = option.first.votes.count
        Voter::vote!(@topic, selected_option).should be_true
        vote_count.should == option.first.votes.count
      end

      pending 'only allows a participant to vote once on a topic' do
      end
    end

    
  end
end