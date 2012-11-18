require 'option'

module Voter
  describe Option do
    before(:each) do
      @option = Option.new
      @option.stub(:save).and_return(true)
    end

    it 'has name and vote_count attributes' do
      @option.should respond_to :name
      @option.should respond_to :vote_count
    end

    it 'can be saved' do
      @option.save!.should be_true
    end
  end
end