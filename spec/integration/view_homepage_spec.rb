require 'spec_helper'

feature 'Viewing the homepage' do
  scenario 'learn about the application' do
    view_homepage
    user_should_see_app_information
  end
end

def user_should_see_app_information
  expect(page).to have_css '[data-role="description"]'
  expect(page).to have_css 'h1.title', text:'Storied the idea blender'
end

def view_homepage
  visit root_path
end
