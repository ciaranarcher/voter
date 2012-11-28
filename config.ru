$:.unshift File.dirname(__FILE__) + '/lib'

require './app/voter_app'
run Voter::App.new