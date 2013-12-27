class HighCard < Hand
  attr_accessor :high
  
  def self.rank
    :high_card
  end
  
  def self.generate(cards)
    hand = HighCard.new
    
    sorted_cards = cards.sort {|a, b| b <=> a} # highest first
    hand.high = sorted_cards[0]
    sorted_cards.delete(hand.high)
    hand.kickers = sorted_cards
    
    return hand
  end
  
  def to_s
    "#{@high.capitalized_rank} high"
  end
  
  def compare_same_rank(high_card)
    @high <=> high_card.high
  end
end