class FiveCardDrawController
  
  def initialize(number_of_players, chips_per_player, ante=1)
    @game = FiveCardDraw.new(number_of_players, chips_per_player)
    @game.ante = ante
    @game.deck = Deck.new
    
    @broadcast = Broadcast.new(number_of_players, :poker)
    
    @player_info_views = Hash.new
    @game.players.each do |player|
      @player_info_views[player] = KeyValueView.new(player.name)
    end
    
    register_callbacks
  end
  
  def take_players
    @broadcast.take_players do |index|
      @broadcast.log "#{@game.players[index].name} joined the game."
    end
  end
  
  def play
    while !@game.winner
      current_deal = @game.start_deal
      @broadcast.log "A new deal has started! You have all been dealt 5 cards."

      while !current_deal[:winner]
        show_betting_players_info
        show_pot current_deal[:pot]
        @broadcast.log "We will now enter a round of betting."
        
        current_deal = @game.play_round_of_betting do |player, min_bet|
          log_to_others(player, "It's #{player.name}'s turn to bet.")
          response = gets_from_player(player, "It's your turn to bet. Enter a number or \"call\" or \"fold\"").chomp
          response.to_i if Float(response) rescue response.to_sym
        end
      end

      winner = current_deal[:winner]
      @broadcast.log "#{winner.name} has won the deal, collecting #{current_deal[:pot]} chips!"
    end
    
    @broadcast.log "#{@game.winner.name} wins the game!"
  end
  
  private
  
  def gets_from_player(player, prompt)
    player_index = @game.players.index(player)
    @broadcast.ask(player_index, prompt)
  end
  
  def register_callbacks
    @game.register(:card_replacements) do |player|
      log_to_others(player, "It's #{player.name}'s turn to replace cards.")
      response = gets_from_player(player, "What cards would you like to replace?").chomp
      response.split(" ").map do |card_string|
        card = card_string.to_card
        [card.rank, card.suit]
      end
    end
    
    @game.register(:did_replace_cards) do |player|
      show_player_info(player)
    end
    
    @game.register(:did_bet) do |player, bet|
      log_to_others(player, "#{player.name} betted #{bet}.")
    end
    
    @game.register(:did_fold) do |player|
      log_to_others(player, "#{player.name} folded.")
    end
  end
  
  def log_to_others(player, message)
    other_player_indexes = @game.betting_players.reject{|p| p == player}.map{|p| @game.players.index(p)}
    @broadcast.log(other_player_indexes, message)
  end
  
  def show_player_info(player)
    view = @player_info_views[player]
    view.cards = player.cards.map{|card| card.to_s}.join(" ")
    view.best_hand = player.best_hand
    view.chips = player.chips.to_s
    
    player_index = @game.players.index(player)
    @broadcast.print_block(player_index, view.to_s)
  end
  
  def show_betting_players_info
    @game.betting_players.each {|player| show_player_info(player)}
  end
  
  def show_pot(pot)
    @broadcast.log "The pot currently has #{pot} chips."
  end
  
end