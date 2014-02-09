class Straight < Hand
  attr_accessor :straight_cards
  attr_reader :valid
  
  def self.rank
    :straight
  end
  
  def initialize(cards=nil) # note that this algorithm will ONLY work when cards has 5 objects
    super() # default Hand initialization
    return if cards == nil
    
    sorted_cards = cards.sort
    last_card = sorted_cards.last
    last_card.low_card = true if last_card.rank == :ace && sorted_cards[cards.length-2].rank != :king
    # ^ assume the presence of a A-2-3-4-5 hand if there is no possibility for a royal straight
    sorted_cards.sort! # order will change if ace is changed to low card
    sorted_values = sorted_cards.map{|card| card.value}
    expected_values = (sorted_values.first..(sorted_values.first + 4)).to_a # if the lowest card is 2, we expect to see 2-3-4-5-6
    
    if sorted_values == expected_values
      @straight_cards = sorted_cards
      @valid = true
    else
      last_card.low_card = false # don't permanently mutate the cards array if the Straight isn't valid
      @valid = false
    end
  end
  
  def self.generate(cards)
    hand = Straight.new(cards)
    hand.valid ? hand : nil
  end
  
  def to_s
    royal? ? "Royal straight" : "#{@straight_cards.last.capitalized_rank}-high straight"
  end
  
  def compare_same_rank(straight)
    @straight_cards.last <=> straight.straight_cards.last
  end
  
  def royal?
    @straight_cards.last.rank == :ace
  end
end