class Game
  attr_accessor :deck
  attr_reader :players, :ante, :pot, :betting_players
  protected :pot, :betting_players
  
  def ante=(ante)
    @ante = ante
    @min_bet = ante if @min_bet < ante
  end
  
  def initialize(number_of_players, chips_per_player)
    @action_to_block_map = Hash.new
    @players = []
    @min_bet = 0
    
    number_of_players.times do
      @players << Player.new(chips_per_player)
    end
    
    reset
  end
  
  def register(sym, &block)
    @action_to_block_map[sym] = block
  end
  
  def winner
    nil
  end
    
  protected
  
  def execute(sym, *args)
    @action_to_block_map[sym].call(*args)
  end
  
  def reset
    @betting_players = @players.dup
    @pot = 0
    
    @players.each do |player|
      player.drop_all
    end
  end
  
  def deal(number_of_cards)
    number_of_cards.times do
      @betting_players.each do |player|
        player.take_cards(@deck.deal)
      end
    end
  end
  
  def ante
    @betting_players.each do |player|
      player.bet(@ante)
      @pot += @ante
    end
  end
  
  def get_bets
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
  end
  
  def best_remaining_player
    best_players = @betting_players.sort{|b, a| a.best_hand <=> b.best_hand} # TODO: fix this, probably very slow
    best_players.first
  end
  
end