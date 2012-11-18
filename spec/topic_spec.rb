require 'topic'

module Voter
  describe Topic do
    before(:each) do
      @topic = Topic.new
    end

    it 'has id and key attributes' do
      @topic.should respond_to :id
      @topic.should respond_to :key
    end
  end
end
