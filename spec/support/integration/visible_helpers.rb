module Visible
  def object_is_visible(object_class, object_name)
    within(:xpath, "//div[@id='#{object_class.pluralize}']") do
      page.should have_content(object_name)
    end
  end
end

RSpec.configure do |config|
  config.include Visible, type: :request
end
