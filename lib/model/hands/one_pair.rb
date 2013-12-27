class OnePair < Hand
  attr_accessor :pair
  
  def self.rank
    :one_pair
  end
  
  def self.generate(cards)
    hand = OnePair.new
    
    ranks = cards.map{|card| card.rank}
    rank_pairs = ranks.select{|rank| ranks.count(rank) == 2}
    hand.pair = cards.select{|card| rank_pairs.include? card.rank}
    hand.kickers = cards.reject{|card| hand.pair.include? card}
    
    hand.pair.length == 2 ? hand : nil
  end
  
  def to_s
    "Pair of #{@pair.first.capitalized_rank}s"
  end
  
  def compare_same_rank(one_pair)
    @pair.first <=> one_pair.pair.first
  end
end