require 'spec_helper'

feature 'Creating a character' do
  scenario 'can view the new character form' do
    go_to_new_object_form("character")
  end

  scenario 'validates name' do
    go_to_new_object_form("character")
    fill_in('Name', :with=>'')
    fill_in('Mentality', :with=>'')
    click_button('Submit')
    should_see_errors_for_fields(['Name'])
  end

  scenario 'saves the character' do
    go_to_new_object_form("character")
    fill_in('Name', :with=>'Black Bart')
    fill_in('Description', :with=>"He's a pirate")
    fill_in('Mentality', :with=>"He is a bad dude.")
    click_button('Submit')
    expect(page).to have_xpath "//div[@class='alert alert-success']"
    within(:xpath, "//div[@class='alert alert-success']") do
      page.should have_content("Character Black Bart was successfully created.")
    end
    object_is_visible("character", "Black Bart")
  end

end

feature "Manage a character" do
  before(:each) do
    visit root_url
    @character = character_on_page
    @character.create
  end

  scenario "shows character details" do
    click_link(@character.name)
    expect(@character).to be_detailed
  end

  scenario "character has mentality" do
    click_link(@character.name)
    page.should have_css 'span.label', text: "Mentality"
  end

  scenario "allows you to edit immediately from the list" do
    @character.select_edit
    form_should_be_visible('edit_character')
    fill_in 'Name', with: "New Bart"
    click_button "Submit"
    page.should have_content("New Bart")
  end

  scenario "allows you to edit from the details page" do
    click_link(@character.name)
    @character.select_edit
    form_should_be_visible('edit_character') 
  end

  scenario "prevents you from submitting invalid edits" do
    @character.select_edit
    fill_in 'Name', with: ""
    click_button "Submit"
    should_see_errors_for_fields(['Name'])
  end

  def character_on_page
    CharacterOnPage.new('Black Bart')
  end

  class CharacterOnPage < Struct.new(:name)
    include Capybara::DSL

    def create
      click_link 'new character'
      fill_in('Name', :with=>name)
      fill_in('Description', :with=>"He's a pirate")
      fill_in('Mentality', :with=>"He is a bad dude.")
      click_button('Submit')
    end

    def visible?
      character_details.has_css? 'p', text: name 
    end
    
    def detailed?
      character_details.has_css? 'p', text: name 
      character_details.has_css? 'span.label', text: "Description"
    end

    def select_edit
      character_item.click_link 'edit'
    end

    private

    def character_details
      find 'div.details'
    end
    
    def character_item
      find "div##{dom_name(Character.new(name: name), 'name')}" 
    end
  end
end
