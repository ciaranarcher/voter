require 'option'

module Voter
  describe Option do
    before(:each) do
      @option = Option.new
      @option.stub(:save!).and_return true
    end

    it 'has name and vote_count attributes' do
      @option.should respond_to :name
    end

    it 'can be saved' do
      @option.name = 'option name'
      @option.save!.should be_true
    end

    it 'can have many votes associated with it' do
      @option.name = 'option with votes'

      5.times do |i|
        # create new option
        v = Vote.new

        # add to topic options
        @option.votes << v
      end

      @option.save!.should be_true
      @option.votes.length.should == 5
    end
  end
end