describe "assignment by id" do
  before do
    class Test::Order
      extend Dry::Initializer

      param  :user,    model: "User"
      option :product, model: Item
    end
  end

  let!(:user) { User.create name: "Dude" }
  let!(:item) { Item.create name: "The thing" }

  it "works when records are present" do
    subject = Test::Order.new(user.id, product: item.id)

    expect(subject.user).to eql user
    expect(subject.product).to eql item
  end

  it "works when records are absent" do
    subject = Test::Order.new(0, product: 0)

    expect(subject.user).to be_nil
    expect(subject.product).to be_nil
  end
end
