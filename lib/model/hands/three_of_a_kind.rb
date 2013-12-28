class ThreeOfAKind < Hand
  attr_accessor :set
  
  def self.rank
    :three_of_a_kind
  end
  
  def self.generate(cards)
    hand = ThreeOfAKind.new
    
    ranks = cards.map{|card| card.rank}
    trips_ranks = ranks.select{|rank| ranks.count(rank) == 3}
    hand.set = cards.select{|card| trips_ranks.include? card.rank}
    hand.kickers = cards.reject{|card| hand.set.include? card}
    
    hand.set.length == 3 ? hand : nil
  end
  
  def to_s
    "Trips (#{@set.first.capitalized_rank.pluralize})"
  end
  
  def compare_same_rank(one_pair)
    @set.first <=> one_pair.set.first
  end
end