class Player
  attr_reader :chips, :cards
  
  def initialize(chips=0)
    @chips = chips
    @cards = []
  end
  
  def bet(chips)
    @chips -= chips
  end
  
  def collect(chips)
    @chips += chips
  end
  
  def take_cards(cards)
    @cards += cards
  end
  
  def drop_card(rank, suit)
    dropped_card = nil
    @cards.reject! do |card|
      if card.rank == rank && card.suit == suit
        dropped_card = card
        true
      else
        false
      end
    end
    
    dropped_card
  end
  
  def drop_all
    dropped_cards = @cards
    @cards = []
    dropped_cards
  end
  
  def best_hand
    sorted_hand_classes.each do |hand_class|
      hand = hand_class.generate(cards)
      return hand if hand != nil
    end
  end
  
  private
  
  def sorted_hand_classes
    @sorted_hand_classes ||=
      [Flush.new, FourOfAKind.new, FullHouse.new,
       HighCard.new, OnePair.new, Straight.new,
       StraightFlush.new, ThreeOfAKind.new,
       TwoPair.new].sort{|a, b| b <=> a}.map{|hand| hand.class}
    @sorted_hand_classes
  end
end