require 'rails_helper'

RSpec.feature "Visitor Adds Item To Their Cart", type: :feature, js: true do
  
        # SETUP
        before :each do
          @category = Category.create! name: 'Add to Cart'
      
            @category.products.create!(
              name:  "Test Cart Name",
              description: "Test Cart Description",
              image: "-",
              quantity: 1,
              price: 45.75
            )
        end

        scenario "User adds an item to their cart" do
          # ACT
          visit "/"
          first("article.product").click_on "Add"
          save_screenshot
          find_link("My Cart (1)").click()
          save_screenshot
          # VERIFY
          expect(find("header.page-header")).to have_content("My Cart")
          expect(page).to have_content("Test Cart Name")
          expect(page).to have_content("$45.75")
          # DEBUG
          puts page.html
          save_screenshot
        end

        
end
