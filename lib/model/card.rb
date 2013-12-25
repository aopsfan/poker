class Card
  include Comparable
  attr_accessor :rank, :suit
  RANKS = [:two, :three, :four, :five, :six, :seven, :eight, :nine, :ten, :jack, :queen, :king, :ace]
  SUITS = [:spades, :hearts, :clubs, :diamonds]
  
  def initialize(rank=nil, suit=nil)
    @rank = rank
    @suit = suit
  end
  
  def <=>(card)
    value <=> card.value
  end
  
  protected
    
  def value
    RANKS.index(@rank)
  end
end
