class Player
  attr_reader :chips, :cards
  attr_accessor :name
  
  def initialize(chips=0)
    @chips = chips
    @cards = []
    @name = "Player"
  end
  
  def bet(chips)
    @chips -= chips
  end
  
  def collect(chips)
    @chips += chips
  end
  
  def take_cards(cards)
    @best_hand = nil
    @cards += cards
  end
  
  def drop_card(rank, suit)
    @best_hand = nil
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
    @best_hand = nil
    dropped_cards = @cards
    @cards = []
    dropped_cards
  end
  
  def best_hand
    @best_hand ||= sorted_hand_classes.inject(nil) do |memo, hand_class|
      memo || hand_class.generate(cards)
    end
  end
  
  private
  
  def sorted_hand_classes
    [
      StraightFlush, FourOfAKind, FullHouse,
      Flush, Straight, ThreeOfAKind,
      TwoPair, OnePair, HighCard
    ]
  end
end