require_relative "poker/version.rb"

require_relative "model/card.rb"
require_relative "model/player.rb"
require_relative "model/game.rb"
require_relative "model/games/five_card_draw.rb"
require_relative "model/deck.rb"
                  
require_relative "model/hand.rb"
require_relative "model/hands/high_card.rb"
require_relative "model/hands/one_pair.rb"
require_relative "model/hands/two_pair.rb"
require_relative "model/hands/three_of_a_kind.rb"
require_relative "model/hands/full_house.rb"
require_relative "model/hands/straight.rb"
require_relative "model/hands/flush.rb"
require_relative "model/hands/four_of_a_kind.rb"
require_relative "model/hands/straight_flush.rb"

require_relative "controller/five_card_draw_controller.rb"

require_relative "view/key_value_view.rb"

require_relative "server/socket_client.rb"
require_relative "server/socket_server.rb"
require_relative "server/broadcast.rb"

module Poker
  # Your code goes here...
  def Poker.greet
    puts "Welcome to Poker (v#{Poker::VERSION})!\n"
  end
end

controller = FiveCardDrawController.new(2, 50, 1)
controller.take_players
controller.play