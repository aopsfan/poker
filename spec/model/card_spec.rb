require_relative "../spec_helper.rb"

describe Card do
  
  let(:two_spades) {Card.new(:two, :spades)}
  let(:ten_diamonds) {Card.new(:ten, :diamonds)}
  let(:ten_clubs) {Card.new(:ten, :clubs)}
  let(:ace_spades) {Card.new(:ace, :spades)}
  
  describe "#new" do
    context "when an ace of spades is created" do
      subject {ace_spades}
      
      it "should be an ace" do
        expect(subject.rank).to eq :ace
      end
      
      it "should be a spade" do
        expect(subject.suit).to eq :spades
      end
    end
  end
  
  describe "#<=>" do
    describe "ten of diamonds" do
      subject {ten_diamonds}

      it "should be greater than a two" do
        should > two_spades
      end

      it "should be less than an ace" do
        should < ace_spades
      end

      it "should be equal to another ten" do
        should == ten_clubs
      end
    end
  end
  
  describe "#to_s" do
    describe "two of spades" do
      it "should output 2S" do
        expect(two_spades.to_s).to match "2S"
      end
    end
    
    describe "ten of diamonds" do
      it "should output 10D" do
        expect(ten_diamonds.to_s).to match "10D"
      end
    end
    
    describe "ace of spades" do
      it "should output AS" do
        expect(ace_spades.to_s).to match "AS"
      end
    end
  end
  
  describe "#value" do
    describe "two of spades" do
      it "should have value 0" do
        expect(two_spades.value).to eq 0
      end
    end
    
    describe "ten of diamonds" do
      it "should have value 8" do
        expect(ten_diamonds.value).to eq 8
      end
    end
    
    describe "ace of spades" do
      it "should have value 12" do
        expect(ace_spades.value).to eq 12
      end
    end
  end
  
  describe "#low_card" do
    context "when low card" do
      card = Card.new(:ace, :clubs)
      card.low_card = true
      subject {card}
      
      it "should be less than a two" do
        should < two_spades
      end

      it "should be less than an ace" do
        should < ace_spades
      end

      it "should be less than a ten" do
        should < ten_clubs
      end
      
      it "should have value -1" do
        expect(subject.value).to eq -1
      end
    end
  end
  
end
