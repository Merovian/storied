require 'spec_helper'

feature "Creating a Location" do
  scenario "can view the new Location form" do
    go_to_new_object_form("location")
  end

  scenario "saves the Location" do
    go_to_new_object_form("location")
    fill_in('Name', with: 'The Atlantic')
    fill_in('Description', with: 'It is an ocean')
    click_button "Submit"
    expect(page).to have_xpath "//div[@class='alert alert-success']"
    within(:xpath, "//div[@class='alert alert-success']") do
      page.should have_content ("Location The Atlantic was successfully created.")
    end
    object_is_visible("location", "The Atlantic")
  end

end


feature "Manage a Location" do
  before(:each) do
    visit root_url
    @location = location_on_page
    @location.create
  end

  scenario "show Location details" do
    click_link(@location.name)
    expect(@location).to be_detailed
  end

  scenario "edit from list" do
    @location.select_edit
    form_should_be_visible('edit_location')
    fill_in 'Name', with: "Pacific"
    click_button "Submit"
    page.should have_content("Pacific")
  end

  scenario "edit from details" do
    click_link(@location.name)
    @location.select_edit
    form_should_be_visible('edit_location')
  end

  scenario "item should not have mentality" do
    click_link(@location.name)
    page.should have_no_css 'span.label', text: "Mentality"
  end


  def location_on_page
    LocationOnPage.new('The Atlantic')
  end

  class LocationOnPage < Struct.new(:name)
    include Capybara::DSL

    def create
      click_link 'new location'
      fill_in('Name', with: name)
      fill_in('Description', with: "It's an ocean")
      click_button('Submit')
    end

    def visible?
      location_details.has_css? 'p', text: name
    end

    def detailed?
      location_details.has_css? 'p', text: name
      location_details.has_css? 'span.label', text: "Description"
    end

    def select_edit
      location_item.click_link 'edit'
    end

    private

    def location_details
      find 'div.details'
    end

    def location_item
      find "div##{dom_name(Location.new(name: name), 'name')}"
    end
  end
end
