describe "modelling relation" do
  before do
    class Test::Order
      extend Dry::Initializer

      param  :user,    model: "User.where(name: 'Dude')"
      option :product, model: Item.where(name: "The thing")
    end
  end

  let!(:user)  { User.create id: 9, name: "Dude" }
  let!(:item)  { Item.create id: 1, name: "The thing" }
  let!(:other) { Item.create id: 2, name: "Another thing" }

  it "uses relation" do
    subject = Test::Order.new(9, product: 1)

    expect(subject.user).to    eq user
    expect(subject.product).to eq item
  end

  it "raises when record not found for the relation" do
    expect { Test::Order.new(9, product: 2) }
      .to raise_error(ActiveRecord::RecordNotFound)
  end
end
