require 'rails_helper'

RSpec.describe Product, type: :model do

  describe 'Validations' do

    before (:all) do
      @product = Product.new
    end

    context "fill out all four fields" do
      it "needs all four fields filled out" do
        @category = Category.create(name: "Test")
        @category.save!
        testProduct = Product.new(name: "tester", price: 10 , quantity: 100, category: @category)
        expect(testProduct).to be_present
      end
    end

    context "validates a name" do
      it "has a name" do
        @product.name = nil
        @product.validate
        expect(@product.errors[:name]).to include("can't be blank")

        @product.name = "tester"
        @product.validate
        expect(@product.errors[:name]).to_not include("can't be blnak")
      end
    end

    context "validates a price" do
      it "has a price" do
        @product.price = nil
        @product.validate
        expect(@product.errors[:price]).to include("is not a number", "can't be blank")

        @product.price = 10
        @product.validate
        expect(@product.errors[:price]).to_not include("is not a number", "can't be blank")
      end
    end

    context "validates a quantity" do
      it "has a quantity" do
        @product.quantity = nil
        @product.validate
        expect(@product.errors[:quantity]).to include("can't be blank")

        @product.quantity = 100
        @product.validate
        expect(@product.errors[:quantity]).to_not include("can't be blank")
      end
    end

    context "validates a category" do
      it "has a category" do
        @product.category = nil
        @product.validate
        expect(@product.errors[:category]).to include("can't be blank")

        @product.category = Category.new
        @product.validate
        expect(@product.errors[:category]).to_not include("can't be blank")
      end
    end
  end
end
