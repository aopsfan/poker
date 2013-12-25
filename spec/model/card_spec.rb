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
  
end
