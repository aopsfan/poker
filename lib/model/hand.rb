class Hand
  include Comparable
  RANKS = [:high_card, :one_pair, :two_pair, :three_of_a_kind, :straight, :flush, :full_house, :four_of_a_kind, :straight_flush]
  attr_accessor :kickers
  
  # subclasses should implement self.rank, self.generate, to_s, and compare_same_rank
  
  def initialize
    @kickers = []
  end
  
  def self.rank
    :dummy_hand
  end
  
  def <=>(hand)
    result = value <=> hand.value
    
    if result == 0 # rank is the same
      result = compare_same_rank(hand)
      if result == 0 # use the kickers
        result = compare_kickers(hand)
      end
    end
    
    result
  end
  
  protected
  
  def value
    RANKS.index(self.class.rank)
  end
  
  private
  
  def compare_kickers(hand)
    return 0 if @kickers.length == 0
    
    index = 0
    result = 0
    kickers = @kickers.sort {|a, b| b <=> a}
    other_kickers = hand.kickers.sort {|a, b| b <=> a}
    
    while result == 0 do
      result = kickers[index] <=> other_kickers[index]
      index == kickers.length - 1 ? break : index += 1
    end
    
    result
  end
end
