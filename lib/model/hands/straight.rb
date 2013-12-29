class Straight < Hand
  attr_accessor :straight_cards
  
  def self.rank
    :straight
  end
  
  def self.generate(cards) # note that this algorithm will ONLY work when cards has 5 objects
    hand = Straight.new
    
    sorted_cards = cards.sort
    last_card = sorted_cards.last
    last_card.low_card = true if last_card.rank == :ace # assume the presence of a A-2-3-4-5 hand
    sorted_cards.sort! # order will change if ace is changed to low card
    sorted_values = sorted_cards.map{|card| card.value}
    expected_values = (sorted_values.first..(sorted_values.first + 4)).to_a # if the lowest card is 2, we expect to see 2-3-4-5-6
    
    if sorted_values == expected_values
      hand.straight_cards = sorted_cards
      hand
    else
      nil
    end
  end
  
  def to_s
    highest_card = @straight_cards.last
    if highest_card.rank == :ace
      "Royal straight"
    else
      "#{highest_card.capitalized_rank}-high straight"
    end
  end
  
  def compare_same_rank(straight)
    @straight_cards.last <=> straight.straight_cards.last
  end
end