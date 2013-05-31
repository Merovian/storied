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


feature "Manage an Item" do
  before(:each) do
    visit root_url
    @item = item_on_page
    @item.create
  end

  scenario "show Item details" do
    click_link(@item.name)
    expect(@item).to be_detailed
  end

  scenario "edit from list" do
    @item.select_edit
    form_should_be_visible('edit_item')
    fill_in 'Name', with: "New Leg"
    click_button "Submit"
    page.should have_content("New Leg")
  end

  scenario "edit from details" do
    click_link(@item.name)
    @item.select_edit
    form_should_be_visible('edit_item')
  end

  scenario "item should not have mentality" do
    click_link(@item.name)
    page.should have_no_css 'span.label', text: "Mentality"
  end


  def item_on_page
    ItemOnPage.new('Peg Leg')
  end

  class ItemOnPage < Struct.new(:name)
    include Capybara::DSL

    def create
      click_link 'new item'
      fill_in('Name', with: name)
      fill_in('Description', with: "It's gross")
      click_button('Submit')
    end

    def visible?
      item_details.has_css? 'p', text: name
    end

    def detailed?
      item_details.has_css? 'p', text: name
      item_details.has_css? 'span.label', text: "Description"
    end

    def select_edit
      item_item.click_link 'edit'
    end

    private

    def item_details
      find 'div.details'
    end

    def item_item
      find "div##{dom_name(Item.new(name: name), 'name')}"
    end
  end
end
