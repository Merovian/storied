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
