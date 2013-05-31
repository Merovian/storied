module Integration

  def go_to_new_object_form(idea_type)
    visit root_path
    click_link("new #{idea_type}")
    form_should_be_visible("new_#{idea_type}")
  end

  def form_should_be_visible(form_id)
    expect(page).to have_xpath "//div[@id='content-entry']/form[@class='#{form_id}']"
  end

  def should_see_errors_for_fields(fields_array=[])
    expect(page).to have_xpath "//div[@class='alert alert-error']"
    within(:xpath, "//div[@class='alert alert-error']") do
      fields_array.each do |field|
        page.should have_content(field)
      end
    end
  end

end

RSpec.configure do |config|
  config.include Integration, type: :request
end
