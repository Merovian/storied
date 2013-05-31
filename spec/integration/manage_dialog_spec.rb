require 'spec_helper'

feature "Creating a Dialog" do
  scenario "can view the new Dialog form" do
    go_to_new_object_form("dialog")
  end

  scenario "saves the Dialog" do
    go_to_new_object_form("dialog")
    fill_in('Name', with: 'Greeting')
    fill_in('Description', with: 'Whazaaaa')
    click_button "Submit"
    expect(page).to have_xpath "//div[@class='alert alert-success']"
    within(:xpath, "//div[@class='alert alert-success']") do
      page.should have_content ("Dialog Greeting was successfully created.")
    end
    object_is_visible("dialog", "Greeting")
  end

end


feature "Manage a Dialog" do
  before(:each) do
    visit root_url
    @dialog = dialog_on_page
    @dialog.create
  end

  scenario "show Dialog details" do
    click_link(@dialog.name)
    expect(@dialog).to be_detailed
  end

  scenario "edit from list" do
    @dialog.select_edit
    form_should_be_visible('edit_dialog')
    fill_in 'Name', with: "Whuzuhhh"
    click_button "Submit"
    page.should have_content("Whuzuhhh")
  end

  scenario "edit from details" do
    click_link(@dialog.name)
    @dialog.select_edit
    form_should_be_visible('edit_dialog')
  end

  scenario "item should not have mentality" do
    click_link(@dialog.name)
    page.should have_no_css 'span.label', text: "Mentality"
  end


  def dialog_on_page
    DialogOnPage.new('Greeting')
  end

  class DialogOnPage < Struct.new(:name)
    include Capybara::DSL

    def create
      click_link 'new dialog'
      fill_in('Name', with: name)
      fill_in('Description', with: "Whazaaaa")
      click_button('Submit')
    end

    def visible?
      dialog_details.has_css? 'p', text: name
    end

    def detailed?
      dialog_details.has_css? 'p', text: name
      dialog_details.has_css? 'span.label', text: "Description"
    end

    def select_edit
      dialog_item.click_link 'edit'
    end

    private

    def dialog_details
      find 'div.details'
    end

    def dialog_item
      find "div##{dom_name(Dialog.new(name: name), 'name')}"
    end
  end
end
