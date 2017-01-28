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
    subject = Test::Order.new(user, product: item)

    expect(subject.user).to eql user
    expect(subject.product).to eql item
  end
end
