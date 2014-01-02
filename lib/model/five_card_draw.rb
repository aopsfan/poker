class FiveCardDraw
  attr_accessor :deck
  attr_reader :players, :active_player, :ante
  
  def ante=(ante)
    @ante = ante
    @min_bet = ante if @min_bet < ante
  end
  
  def initialize(number_of_players, chips_per_player)
    @action_for = Hash.new
    @players = []
    @min_bet = 0
    @pot = 0
    
    number_of_players.times do
      @players << Player.new(chips_per_player)
    end
    
    @betting_players = @players.dup
  end
  
  def action(sym, &block)
    @action_for[sym] = block
  end
  
  def active_player_number
    index_to_player @players.index(@active_player)
  end
  
  def play_round
    # deal
    5.times do
      @betting_players.each do |player|
        player.take_cards(@deck.deal)
      end
    end
    
    # ante up
    @betting_players.each do |player|
      @pot += ante
      player.bet(ante)
      @active_player = player
      @action_for[:ante].call
    end
    
    # first round of betting
    @action_for[:enter_first_round_of_betting].call
    request_bets
    
    # request cards
    @betting_players.each do |player|
      @active_player = player
      dropped_cards = @action_for[:request_cards].call
      
      dropped_cards.each do |card_array|
        player.drop_card(card_array.first, card_array.last)
      end
      player.take_cards(@deck.deal(dropped_cards.length))
    end
    
    # second round of betting
    @action_for[:enter_second_round_of_betting].call
    request_bets
    
    # deal pot :P
    best_players = @betting_players.sort{|b, a| a.best_hand <=> b.best_hand} # TODO: fix this, probably very slow
    winner = best_players.first
    winner.collect(@pot)
    @action_for[:collect_pot].call(index_to_player @betting_players.index(winner))
    
    # reset everything
    @betting_players = @players
    @pot = 0
    @active_player = nil
  end
  
  private
  
  def index_to_player(index)
    index + 1
  end
  
  def request_bets
    folding_players = []
    @betting_players.each do |player|
      @active_player = player
      bet = @action_for[:bet].call(@min_bet)
      
      if bet == :fold
        folding_players << player
      else
        player.bet(bet)
        @min_bet = bet
        @pot += bet
      end
    end
    
    @betting_players.reject!{|player| folding_players.include? player}
  end
  
end