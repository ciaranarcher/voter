require 'spec_helper'
require 'participant'

module Voter
  describe Participant do
   before(:each) do
      @person = Participant.new
      stub_save! @person
    end

    it 'has id and created_at attributes' do
      @person.should respond_to :email
      @person.should respond_to :name
      @person.should respond_to :created_at
    end

    it 'can be saved' do
      @person.name = 'test participant'
      @person.email = 'foo@bar.com'
      @person.save!
    end
  end
end