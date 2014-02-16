class Game
  attr_accessor :deck
  attr_reader :players, :ante, :pot, :betting_players, :active_players
  protected :pot
  
  def ante=(ante)
    @ante = ante
    @min_bet = ante if @min_bet < ante
  end
  
  def initialize(number_of_players, chips_per_player)
    @action_to_block_map = Hash.new
    @players = []
    @min_bet = 0
    
    index = 0
    names = ["Bruce", "Mom", "Loser 1", "Loser 2", "Buttface", "Facebutt"]
    
    number_of_players.times do
      player = Player.new(chips_per_player)
      player.name = names[index % number_of_players]
      @players << player
      
      index += 1
    end
    
    @active_players = @players.dup
    reset
  end
  
  def register(sym, &block)
    @action_to_block_map[sym] = block
  end
  
  def winner
    @active_players.count == 1 ? @active_players.first : nil
  end
    
  protected
  
  def execute(sym, *args)
    @action_to_block_map[sym].call(*args) if @action_to_block_map[sym]
  end
  
  def reset
    @active_players.reject!{|player| player.chips == 0}
    @betting_players = @active_players.dup
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
        execute(:did_fold, player)
      else
        bet_value = bet == :call ? @min_bet : bet
        player.bet(bet_value)
        @min_bet = bet_value
        @pot += bet_value
        execute(:did_bet, player, bet_value)
      end
    end
    
    @betting_players.reject!{|player| folding_players.include? player}
  end
  
  def best_remaining_player
    best_players = @betting_players.sort{|b, a| a.best_hand <=> b.best_hand} # TODO: fix this, probably very slow
    best_players.first
  end
  
end