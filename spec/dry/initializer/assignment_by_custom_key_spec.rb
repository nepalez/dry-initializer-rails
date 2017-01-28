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

    it "works when records are absent" do
      subject = Test::Order.new("Man", product: "Something strange")

      expect(subject.user).to be_nil
      expect(subject.product).to be_nil
    end
  end

  context "with container syntax" do
    before do
      class Test::Order
        include Dry::Initializer.define -> do
          param  :user,    model: "User", find_by: "name"
          option :product, model: Item,   find_by: :name
        end
      end
    end

    let!(:user) { User.create name: "Dude" }
    let!(:item) { Item.create name: "The thing" }

    it "works when records are present" do
      subject = Test::Order.new("Dude", product: "The thing")

      expect(subject.user).to eql user
      expect(subject.product).to eql item
    end

    it "works when records are absent" do
      subject = Test::Order.new("Man", product: "Something strange")

      expect(subject.user).to be_nil
      expect(subject.product).to be_nil
    end
  end
end
