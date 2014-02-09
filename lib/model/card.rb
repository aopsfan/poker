class Card
  include Comparable
  attr_accessor :rank, :suit, :low_card
  RANKS = [:two, :three, :four, :five, :six, :seven, :eight, :nine, :ten, :jack, :queen, :king, :ace]
  SUITS = {:spades => 'S', :hearts => 'H', :clubs => 'C', :diamonds => 'D'}
  STRING_RANKS = %w[2 3 4 5 6 7 8 9 10 J Q K A]
  
  def initialize(rank=nil, suit=nil)
    @rank = rank
    @suit = suit
  end
  
  def <=>(card)
    value <=> card.value
  end
  
  def to_s
    "#{rank_string}#{suit_string}"
  end
  
  def inspect
    "{Card: rank => :#{@rank}, suit => :#{@suit}}"
  end
  
  def capitalized_rank
    @rank.to_s.capitalize
  end
  
  def value
    @low_card ? -1 : RANKS.index(@rank)
  end
    
  private
  
  def rank_string
    STRING_RANKS[value]
  end
  
  def suit_string
    SUITS[suit]
  end
end

class String
  def pluralize
    self[self.size - 1] == 'x' ? self + "es" : self + "s"
  end
  
  def to_card # LORD FORIVE ME FOR THIS AWFUL CODE
    if size == 2
      rank = self[0]
      suit = self[1]
    elsif size == 3
      rank = self[0..1]
      suit = self[2]
    end
    ranks_index = Card::STRING_RANKS.index(rank)
    Card.new(Card::RANKS[ranks_index], Card::SUITS.find{|key, value| value == suit}.first)
  end
end
