require 'spec_helper'
require 'topic'
require 'vote_option'
require 'participant'

module Voter 
  describe Topic do
    before(:each) do
      @topic = Topic.new
      stub_save! @topic
    end

    it 'has id and key attributes' do
      @topic.should respond_to :name
      @topic.should respond_to :key
    end

    it 'can be saved' do
      @topic.name = 'test'
      @topic.key = 'xyz'
      @topic.save!
    end

    it 'has embedded vote_options which can be saved too' do
      5.times do |i|
        # create new option
        o = VoteOption.new
        stub_save! o
        o.name = 'option name ' + i.to_s

        # add to topic vote_options
        @topic.vote_options << o
      end

      @topic.save!
    end

    it 'has vote_options to vote on' do
      @topic.vote_options.should be_instance_of Array
    end

    it 'can have participants associated with it' do
      p = Participant.new
      p.stub(:save!).and_return true
      p.name = 'Ciaran'
      p.email = 'foo@bar.com'
      p.save!

      @topic.participants << p
      @topic.save!
    end
  end
end