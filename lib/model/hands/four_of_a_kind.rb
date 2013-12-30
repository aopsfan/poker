class FourOfAKind < Hand
  attr_accessor :set
  
  def self.rank
    :four_of_a_kind
  end
  
  def self.generate(cards)
    hand = FourOfAKind.new
    
    ranks = cards.map{|card| card.rank}
    trips_ranks = ranks.select{|rank| ranks.count(rank) == 4}
    hand.set = cards.select{|card| trips_ranks.include? card.rank}
    hand.kickers = cards.reject{|card| hand.set.include? card}
    
    hand.set.length == 4 ? hand : nil
  end
  
  def to_s
    "Quads (#{@set.first.capitalized_rank.pluralize})"
  end
  
  def compare_same_rank(one_pair)
    @set.first <=> one_pair.set.first
  end
end