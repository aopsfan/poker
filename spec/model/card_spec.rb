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
  
end
