class TwoPair < Hand
  attr_accessor :low_pair, :high_pair
  
  def self.rank
    :two_pair
  end
  
  def self.generate(cards)
    hand = TwoPair.new
    
    ranks = cards.map{|card| card.rank}
    rank_pairs = ranks.select{|rank| ranks.count(rank) == 2}
    sorted_card_pairs = cards.select{|card| rank_pairs.include? card.rank}.sort
    
    if sorted_card_pairs.length == 4
      hand.low_pair = [sorted_card_pairs[0], sorted_card_pairs[1]]
      hand.high_pair = [sorted_card_pairs[2], sorted_card_pairs[3]]
      hand.kickers = cards.reject{|card| sorted_card_pairs.include? card}
      
      hand
    else
      nil
    end
  end
  
  def to_s
    "#{@high_pair.first.capitalized_rank.pluralize} over #{@low_pair.first.capitalized_rank.pluralize}"
  end
  
  def compare_same_rank(two_pair)
    result = @high_pair.first <=> two_pair.high_pair.first
    result == 0 ? @low_pair.first <=> two_pair.low_pair.first : result
  end
end