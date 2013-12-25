class Card
  attr_accessor :rank, :suit
  
  def initialize(rank=nil, suit=nil)
    @rank = rank
    @suit = suit
  end
end