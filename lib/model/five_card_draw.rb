class FiveCardDraw
  attr_accessor :deck
  attr_reader :players, :active_player, :ante
  
  def ante=(ante)
    @ante = ante
    @min_bet = ante if @min_bet < ante
  end
  
  def initialize(number_of_players, chips_per_player)
    @action_to_block_map = Hash.new
    @players = []
    @min_bet = 0
    @pot = 0
    @final_round = false
    
    number_of_players.times do
      @players << Player.new(chips_per_player)
    end
    
    @betting_players = @players.dup
  end
  
  def register(sym, &block)
    @action_to_block_map[sym] = block
  end
  
  def winner
    nil
  end
  
  def start_deal
    # deal
    5.times do
      @betting_players.each do |player|
        player.take_cards(@deck.deal)
      end
    end
    
    # ante
    @betting_players.each do |player|
      player.bet(@ante)
      @pot += @ante
    end
    
    # return deal info
    {:pot => @pot}
  end
  
  def play_round_of_betting
    if @final_round
      # request cards
      @betting_players.each do |player|
        dropped_cards = @action_to_block_map[:replace_cards].call(player)
        
        dropped_cards.each do |card_array|
          player.drop_card(card_array.first, card_array.last)
        end
        player.take_cards(@deck.deal(dropped_cards.length))
      end
    end
    
    # bet
    folding_players = []
    @betting_players.each do |player|
      bet = yield(player, @min_bet)
      
      if bet == :fold
        folding_players << player
      elsif bet == :call
        player.bet(@min_bet)
        @pot += @min_bet
      else
        player.bet(bet)
        @min_bet = bet
        @pot += bet
      end
    end
    
    @betting_players.reject!{|player| folding_players.include? player}
    round_over = @final_round || @betting_players.count == 1
    
    # finish up
    deal = {:pot => @pot}
    
    if round_over
      # deal pot :P
      best_players = @betting_players.sort{|b, a| a.best_hand <=> b.best_hand} # TODO: fix this, probably very slow
      winner = best_players.first
      winner.collect(@pot)
      deal[:winner] = winner
      
      # reset everything
      @betting_players = @players
      @pot = 0
    end
    
    # change round number
    @final_round = !@final_round
    
    # return deal info
    deal
  end
  
end