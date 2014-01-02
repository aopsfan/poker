class Deck
  
  def initialize(cards=nil)
    @cards = cards == nil ? all_cards : cards.map{|s| s.to_card}
  end
  
  def length
    @cards.length
  end
  
  def [](index)
    @cards[index]
  end
  
  def deal(number_of_cards=1)
    dealt_cards = []
    number_of_cards.times do
      dealt_cards << @cards.shift
    end
    dealt_cards
  end
  
  private
  
  def all_cards
    cards = []
    Card::RANKS.each do |rank|
      Card::SUITS.each do |suit, string|
        cards << Card.new(rank, suit)
      end
    end
    cards.shuffle
  end
  
end