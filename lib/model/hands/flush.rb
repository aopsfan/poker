class Flush < Hand
  attr_accessor :flush_cards
  
  def self.rank
    :flush
  end
  
  def self.generate(cards) # note: as with Straight, this algorithm only works when cards have 5 objects
    if cards.map{|card| card.suit}.uniq.length == 1
      hand = Flush.new
      hand.flush_cards = cards
      hand
    end
  end
  
  def to_s
    "#{highest_card.capitalized_rank}-high flush"
  end
  
  def compare_same_rank(flush)
    cards = @flush_cards.sort {|a, b| b <=> a}
    other_cards = flush.flush_cards.sort {|a, b| b <=> a}
    result = 0
    cards.each_with_index do |card, index|
      result = card <=> other_cards[index]
      break if result != 0
    end
    
    result
  end
  
  private
  
  def highest_card
    @highest_card ||= @flush_cards.sort.last
  end
end