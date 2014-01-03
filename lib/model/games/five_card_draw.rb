class FiveCardDraw < Game
  
  def initialize(number_of_players, chips_per_player)
    super(number_of_players, chips_per_player)
    @final_round = false
  end
  
  def start_deal
    deal(5)
    ante
    {:pot => pot}
  end
  
  def play_round_of_betting
    if @final_round
      # request cards
      betting_players.each do |player|
        dropped_cards = execute(:replace_cards, player)
        
        dropped_cards.each do |card_array|
          player.drop_card(card_array.first, card_array.last)
        end
        player.take_cards(@deck.deal(dropped_cards.length))
      end
    end
    
    # bet
    get_bets do |player, min_bet|
      yield(player, min_bet)
    end
    round_over = @final_round || betting_players.count == 1
    
    # finish up
    deal = {:pot => pot}
    
    if round_over
      winner = best_remaining_player
      winner.collect(@pot)
      deal[:winner] = winner
      reset
    end
    
    @final_round = !@final_round
    deal
  end
  
end