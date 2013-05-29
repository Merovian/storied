require 'spec_helper'

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

  scenario "allows you to edit immediately from the list" do
    @character.select_edit
    form_should_be_visible('edit_character')
    fill_in 'Name', with: "New Bart"
    click_button "Create"
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
    click_button "Create"
    page.should have_content("prohibited this character")
  end

  def form_should_be_visible(form_id)
    expect(page).to have_xpath "//div[@id='content-entry']/form[@class='#{form_id}']"
  end

  def character_on_page
    CharacterOnPage.new('Black Bart')
  end

  class CharacterOnPage < Struct.new(:name)
    include Capybara::DSL

    def create
      click_link 'character'
      fill_in('Name', :with=>name)
      fill_in('Age', :with=>'31')
      fill_in('Description', :with=>"He's a pirate")
      fill_in('Conflict', :with=>"He is a bad dude.")
      click_button('Create')
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
