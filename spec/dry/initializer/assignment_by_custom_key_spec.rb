describe "assignment by custom key" do
  context "with mixin syntax" do
    before do
      class Test::Order
        extend Dry::Initializer

        param  :user,    model: "User", find_by: "name"
        option :product, model: Item,   find_by: :name
      end
    end

    let!(:user) { User.create name: "Dude" }
    let!(:item) { Item.create name: "The thing" }

    it "works when records are present" do
      subject = Test::Order.new("Dude", product: "The thing")

      expect(subject.user).to eql user
      expect(subject.product).to eql item
    end

    it "raises when records are absent" do
      Test::Order.new("Dude", product: "The thing")

      expect { Test::Order.new("Man", product: "The thing") }
        .to raise_error ActiveRecord::RecordNotFound

      expect { Test::Order.new("Dude", product: "Something strange") }
        .to raise_error ActiveRecord::RecordNotFound
    end
  end
end
