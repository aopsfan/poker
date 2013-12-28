class FullHouse < Hand
  attr_accessor :set, :pair
  
  def self.rank
    :full_house
  end
  
  def self.generate(cards)
    hand = FullHouse.new
    
    ranks = cards.map{|card| card.rank}
    set_ranks = ranks.select{|rank| ranks.count(rank) == 3}
    ranks = ranks - set_ranks
    pair_ranks = ranks.select{|rank| ranks.count(rank) == 2}
    hand.set = cards.select{|card| set_ranks.include? card.rank}
    hand.pair = cards.select{|card| pair_ranks.include? card.rank}
    
    hand.set.length == 3 && hand.pair.length == 2 ? hand : nil
  end
  
  def to_s
    "#{@set.first.capitalized_rank.pluralize} full of #{@pair.first.capitalized_rank.pluralize}"
  end
  
  def compare_same_rank(two_pair)
    @set.first <=> two_pair.set.first # since there are only 4 suits, this will never return 0
  end
end