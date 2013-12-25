class Hand
  include Comparable
  RANKS = [:high_card, :one_pair, :two_pair, :three_of_a_kind, :straight, :flush, :full_house, :four_of_a_kind, :straight_flush]
  attr_accessor :kickers
  
  def initialize
    @kickers = []
  end
  
  def self.rank
    :invalid # overriden by subclasses
  end
  
  def title
    "Hand" # overriden by subclasses
  end
  
  def <=>(hand)
    value <=> hand.value
  end
  
  def compare_kickers(hand)
    index = result = 0
    kickers = @kickers.sort {|a, b| b <=> a}
    other_kickers = hand.kickers.sort {|a, b| b <=> a}
    
    while result == 0 do
      result = kickers[index] <=> other_kickers[index]
      index == kickers.length - 1 ? break : index += 1
    end
    
    result
  end
  
  protected
  
  def value
    RANKS.index(self.class.rank)
  end
end
