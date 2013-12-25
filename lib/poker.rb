require_relative "poker/version.rb"

module Poker
  # Your code goes here...
  def Poker.greet
    puts "Welcome to Poker (v#{Poker::VERSION})!"
  end
end

Poker.greet