require 'spec_helper'

feature "Creating an Item" do
  scenario "can view the new Item form" do
    go_to_new_object_form("item")
  end

  scenario "saves the Item" do
    go_to_new_object_form("item")
    fill_in('Name', with: 'Peg Leg')
    fill_in('Description', with: 'It is gross')
    click_button "Submit"
    expect(page).to have_xpath "//div[@class='alert alert-success']"
    within(:xpath, "//div[@class='alert alert-success']") do
      page.should have_content ("Item Peg Leg was successfully created.")
    end
    object_is_visible("item", "Peg Leg")
  end

end
