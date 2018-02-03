describe "assignment by model" do
  before do
    class Test::Order
      extend Dry::Initializer

      param  :user,    model: "User"
      option :product, model: Item
    end
  end

  let!(:user) { User.create name: "Dude" }
  let!(:item) { Item.create name: "The thing" }

  it "works" do
    subject = Test::Order.new(nil, product: nil)

    expect(subject.user).to be_nil
    expect(subject.product).to be_nil
  end
end
