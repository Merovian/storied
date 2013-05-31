require 'spec_helper'

feature 'Creating a set_piece' do
  scenario 'can view the new set_piece form' do
    go_to_new_object_form("set_piece")
  end

  scenario 'validates name' do
    go_to_new_object_form("set_piece")
    fill_in('Name', :with=>'')
    click_button('Submit')
    should_see_errors_for_fields(['Name'])
  end

  scenario 'saves the set_piece' do
    go_to_new_object_form("set_piece")
    fill_in('Name', :with=>'Wicked Flatus')
    fill_in('Description', :with=>"Something goes bang!")
    fill_in('Start state', :with=>"Everyone is happy.")
    fill_in('End state', :with=>"Everyone is sad.")
    click_button('Submit')
    expect(page).to have_xpath "//div[@class='alert alert-success']"
    within(:xpath, "//div[@class='alert alert-success']") do
      page.should have_content("Set Piece Wicked Flatus was successfully created.")
    end
    object_is_visible("set_piece", "Wicked Flatus")
  end

end

feature "Manage a set_piece" do
  before(:each) do
    visit root_url
    @set_piece = set_piece_on_page
    @set_piece.create
  end

  scenario "shows set_piece details" do
    click_link(@set_piece.name)
    expect(@set_piece).to be_detailed
  end

  scenario "set_piece has no mentality" do
    click_link(@set_piece.name)
    page.should have_no_css 'span.label', text: "Mentality"
  end

  scenario "set_piece has start and end states" do
    click_link(@set_piece.name)
    page.should have_css 'span.label', text: "Start state"
    page.should have_css 'span.label', text: "End state"
  end

  scenario "allows you to edit immediately from the list" do
    @set_piece.select_edit
    form_should_be_visible('edit_set_piece')
    fill_in 'Name', with: "Sad Trombone"
    click_button "Submit"
    page.should have_content("Sad Trombone")
  end

  scenario "allows you to edit from the details page" do
    click_link(@set_piece.name)
    @set_piece.select_edit
    form_should_be_visible('edit_set_piece') 
  end


  def set_piece_on_page
    SetPieceOnPage.new('Wicked Flatus')
  end

  class SetPieceOnPage < Struct.new(:name)
    include Capybara::DSL

    def create
      click_link 'new set piece'
      fill_in('Name', :with=>name)
      fill_in('Description', :with=>"Something goes pow!")
      fill_in('Start state', :with=>"Everyone is smiling.")
      fill_in('End state', :with=>"Everyone is frowning.")
      click_button('Submit')
    end

    def visible?
      set_piece_details.has_css? 'p', text: name 
    end
    
    def detailed?
      set_piece_details.has_css? 'p', text: name 
      set_piece_details.has_css? 'span.label', text: "Description"
    end

    def select_edit
      set_piece_item.click_link 'edit'
    end

    private

    def set_piece_details
      find 'div.details'
    end
    
    def set_piece_item
      find "div##{dom_name(SetPiece.new(name: name), 'name')}" 
    end
  end
end
