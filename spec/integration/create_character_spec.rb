require 'spec_helper'

feature 'Creating a character' do
  scenario 'can view the new character form' do
    go_to_new_character_page
  end

  scenario 'validates name and age' do
    go_to_new_character_page
    fill_in('Name', :with=>'')
    fill_in('Age', :with=>'what the heck')
    click_button('Create')
    should_see_errors_for_fields(['Name', 'Age'])
  end

  scenario 'saves the character' do
    go_to_new_character_page
    fill_in('Name', :with=>'Black Bart')
    fill_in('Age', :with=>'31')
    fill_in('Description', :with=>"He's a pirate")
    fill_in('Conflict', :with=>"He is a bad dude.")
    click_button('Create')
    expect(page).to have_xpath "//div[@class='alert alert-success']"
    within(:xpath, "//div[@class='alert alert-success']") do
      page.should have_content("Character Black Bart was successfully created.")
    end
    character_is_visible("Black Bart")
  end

  def character_is_visible(character_name)
    within(:xpath, "//div[@id='characters']") do
      page.should have_content(character_name)
    end
  end

  def go_to_new_character_page
    visit root_path
    click_link('character')
    form_should_be_visible('new_character')
  end

  def form_should_be_visible(form_id)
    expect(page).to have_xpath "//div[@id='content-entry']/form[@id='#{form_id}']"
  end

  def should_see_errors_for_fields(fields_array=[])
    expect(page).to have_xpath "//div[@id='errorExplanation']"
    within(:xpath, "//div[@id='errorExplanation']") do
      fields_array.each do |field|
        page.should have_content(field)
      end
    end
  end

end
