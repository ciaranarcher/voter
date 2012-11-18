require 'spec_helper'
require 'topic'

module Voter
  describe Topic do
    before(:each) do
      @topic = Topic.new
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
  end
end
