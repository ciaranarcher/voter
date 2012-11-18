require 'spec_helper'
require 'topic'
require 'option'

module Voter
  describe Topic do
    before(:each) do
      @topic = Topic.new
      @topic.stub(:save!).and_return true
    end

    it 'has id and key attributes' do
      @topic.should respond_to :name
      @topic.should respond_to :key
    end

    it 'can be saved' do
      @topic.name = 'test'
      @topic.key = 'xyz'
      @topic.options
      @topic.save!
    end

    it 'has embedded options which can be saved too' do
      options = []
      5.times do |i|
        # create new option
        o = Option.new
        o.name = 'option name ' + i.to_s
        o.vote_count = rand(1..100)

        # add to topic options
        @topic.options << o
      end

      @topic.save!
    end

    it 'has options to vote on' do
      @topic.options.should be_instance_of Array
    end
  end
end