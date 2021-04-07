require 'rails_helper'

RSpec.feature "Visitor sees the Product Details", type: :feature, js: true do
  
      # SETUP
      before :each do
        @category = Category.create! name: 'Product Details'
    
          @category.products.create!(
            name: "New Product Name",
            description: "New Description",
            image: open_asset('apparel2.jpg'),
            quantity: 1,
            price: 45.75
          )
      end

      scenario "Product Details appear when product is chosen" do
        # ACT
        visit "/products"
        first("article.product").click_on("Details »")

        #VERIFY
        expect(page).to have_content("New Product Name")
        expect(page).to have_content("45.75")

        # DEBUG
        save_screenshot
      end
end
