require_relative "../spec_helper.rb"

describe Card do
  
  describe "#new" do
    
    context "when an ace of spades is created" do
      let(:ace_spades) {Card.new(:ace, :spades)}
      subject {ace_spades}
      
      it "should be an ace" do
        subject.rank.should == :ace
      end
      
      it "should be a spade" do
        subject.suit.should == :spades
      end
      
    end
    
  end
  
  describe "#<=>" do
    
    let(:ten_diamonds) {Card.new(:ten, :diamonds)}
    let(:two_spades) {Card.new(:two, :spades)}
    let(:ace_spades) {Card.new(:ace, :spades)}
    let(:ten_clubs) {Card.new(:ten, :clubs)}
    subject {ten_diamonds}
    
    context "when a ten is compared to a two" do
      it {should > two_spades}
    end
    
    context "when a ten is compared to an ace" do
      it {should < ace_spades}
    end
    
    context "when a ten is compared to another ten" do
      it {should == ten_clubs}
    end
    
  end
  
end
