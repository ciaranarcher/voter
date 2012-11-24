require 'spec_helper'
require 'topic'
require 'option'
require 'participant'

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
      5.times do |i|
        # create new option
        o = Option.new
        o.stub(:save!).and_return true
        o.name = 'option name ' + i.to_s

        # add to topic options
        @topic.options << o
      end

      @topic.save!
    end

    it 'has options to vote on' do
      @topic.options.should be_instance_of Array
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