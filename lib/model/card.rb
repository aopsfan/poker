class Card
  include Comparable
  attr_accessor :rank, :suit
  RANKS = [:two, :three, :four, :five, :six, :seven, :eight, :nine, :ten, :jack, :queen, :king, :ace]
  SUITS = [:spades, :hearts, :clubs, :diamonds]
  STRING_RANKS = %w[2 3 4 5 6 7 8 9 10 J Q K A]
  STRING_SUITS = %w[S H C D]
  
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
  
  protected
    
  def value
    RANKS.index(@rank)
  end
  
  private
  
  def rank_string
    STRING_RANKS[value]
  end
  
  def suit_string
    STRING_SUITS[SUITS.index(@suit)] # gag
  end
end
