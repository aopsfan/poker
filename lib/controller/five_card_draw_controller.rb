class FiveCardDrawController
  
  def initialize(number_of_players, chips_per_player, ante)
    @game = FiveCardDraw.new(number_of_players, chips_per_player)
    @game.ante = ante
    @game.deck = Deck.new
    
    @player_info_views = Hash.new
    @game.players.each do |player|
      @player_info_views[player] = KeyValueView.new(player.name)
    end
    
    @input_view = InputView.new
  end
  
  def play
    @game.register(:replace_cards) do |player|
      response = @input_view.get_input(player.name, "What cards would you like to replace?").chomp
      response.split(" ").map do |card_string|
        card = card_string.to_card
        [card.rank, card.suit]
      end
    end

    while !@game.winner
      current_deal = @game.start_deal
      LogView.log "A new deal has started! You have all been dealt 5 cards."
      show_player_info
      show_pot current_deal[:pot]

      while !current_deal[:winner]
        LogView.log "We will now enter a round of betting."
        current_deal = @game.play_round_of_betting do |player, min_bet|
          response = @input_view.get_input(player.name, "It's your turn to bet. Enter a number or \"call\" or \"fold\"").chomp
          response.to_i if Float(response) rescue response.to_sym
        end
        
        show_player_info
        show_pot current_deal[:pot]
      end

      LogView.log "#{current_deal[:winner].name} has won the deal, collecting #{current_deal[:pot]} chips!"
    end
    
    LogView.log "#{@game.winner.name} wins the game!"
  end
  
  private
  
  def show_player_info
    @player_info_views.each do |player, view|
      view.cards = player.cards.map{|card| card.to_s}.join(" ")
      view.best_hand = player.best_hand
      view.chips = player.chips.to_s
      
      view.print
    end
  end
  
  def show_pot(pot)
    LogView.log "The pot currently has #{pot} chips."
  end
  
end