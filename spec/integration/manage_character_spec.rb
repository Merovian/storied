require 'spec_helper'

feature "Manage a character" do
  scenario "shows character details" do
    visit root_url
    character = character_on_page
    character.create

    click_link(character.name)
    expect(character).to be_detailed
  end

  scenario "allows you to edit immediately from the list" do
    visit root_url
    character = character_on_page
    character.create

    character.select_edit
    
    form_should_be_visible('edit_character')
  end

  scenario "allows you to edit from the details page" do
    visit root_url
    character = character_on_page
    character.create
    click_link(character.name)
    character.select_edit
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
      find "div##{Character.new(name: name).dom_name}"
    end
  end
end
