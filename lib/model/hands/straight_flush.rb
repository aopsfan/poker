class StraightFlush < Straight  
  def self.rank
    :straight_flush
  end
  
  def self.generate(cards) # note that this algorithm will ONLY work when cards has 5 objects
    hand = Straight.generate cards
    if hand != nil && cards.map{|card| card.suit}.uniq.length == 1
      hand
    end
  end
  
  def to_s
    royal? ? "Royal flush" : "#{super.to_s} flush"
  end
end