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

  it "raises when records are absent" do
    subject = Test::Order.new(user.id, product: item.id)

    expect { Test::Order.new(0, product: item) }
      .to raise_error ActiveRecord::RecordNotFound

    expect { Test::Order.new(user, product: 0) }
      .to raise_error ActiveRecord::RecordNotFound
  end
end
