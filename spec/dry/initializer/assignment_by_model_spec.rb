describe "assignment by model" do
  before do
    class Test::Order
      extend Dry::Initializer

      param  :user,    model: "User"
      option :product, model: Item
    end
  end

  let(:user) { User.create name: "Dude" }
  let(:item) { Item.create name: "The thing" }

  subject(:service) { Test::Order.new(user, product: item) }

  it "works" do
    expect(subject.user).to eql user
    expect(subject.product).to eql item
  end

  context "when option is not instance of class" do
    let(:item) { User.create name: "NotAnItem" }

    it "rejects" do
      expect { service }
        .to raise_error(ArgumentError, "Value `User` is not instance of `Item`")
    end
  end
end
