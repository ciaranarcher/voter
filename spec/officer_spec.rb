require 'spec_helper'
require 'officer'
require 'topic'
require 'participant'
require 'digest/sha1'

module Voter
  describe Officer do
    before(:each) do
      # setup a topic with a specific key
      @key = Digest::SHA1.hexdigest('foo' + Time.now.to_s)
      @topic = Topic.new
      stub_save! @topic
      @topic.name = 'test'
      @topic.key = @key

      o1 = VoteOption.new
      stub_save! o1
      o1.name = 'red'
      o1.save!

      o2 = VoteOption.new
      stub_save! o2
      o2.name = 'blue'
      o2.save!

      # add to topic vote_options
      @topic.vote_options << o1 << o2
      @topic.save!

      # create a participants
      @person_a = Participant.new(name: 'Person A', email: 'person_a@bar.com')
      stub_save! @person_a
      @person_a.save!

      @person_b = Participant.new(name: 'Person B', email: 'person_b@bar.com')
      stub_save! @person_b
      @person_b.save!

      @person_c = Participant.new(name: 'Person C', email: 'person_c@bar.com')
      stub_save! @person_c
      @person_c.save!
    end

    describe 'supervising voting' do
      it 'only allows a participant vote on a topic if they have the correct key' do
        # check voting allowed by comparing key to topic
        Officer::voting_allowed?(@topic, @key).should be_true
      end

      it 'raises an exception if a vote is attempted on a non-existent option' do
        lambda {Officer::vote!(@topic, @person_a, 'foo')}.should raise_error 'voting option not found'
      end

      it 'allows a vote to be made on a option' do
        selected_option = 'red'
        option = @topic.vote_options.select {|o| o.name == selected_option}
        vote_count = option.first.votes.count
        Officer::vote!(@topic, @person_a, selected_option).should be_true
        vote_count.should == option.first.votes.count
      end

      it 'only allows a participant to vote once on a topic' do
        selected_option = 'red'
        Officer::vote!(@topic, @person_a, selected_option).should be_true
        lambda {Officer::vote!(@topic, @person_a, selected_option)}.should raise_error 'voted before'
      end
    end

    describe 'reporting on voting' do
      it 'reports vote_options for a topic in order of most votes descending' do
        Officer::vote!(@topic, @person_a, 'red')
        Officer::vote!(@topic, @person_b, 'blue')
        Officer::vote!(@topic, @person_c, 'blue')

        ranked_vote_options = Officer::report_ranked_desc(@topic)
        ranked_vote_options.should be_instance_of Array
        ranked_vote_options.first.name.should == 'blue'
        ranked_vote_options.last.name.should == 'red'
      end
    end
  end
end