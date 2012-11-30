require 'vote_option'

module Voter
  describe VoteOption do
    before(:each) do
      @option = VoteOption.new
      stub_save! @option
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

        # add to topic vote_options
        @option.votes << v
      end

      @option.save!.should be_true
      @option.votes.length.should == 5
    end
  end
end