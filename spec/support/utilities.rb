def dom_name(object, attribute='id')
  "#{object.class.to_s.downcase}_#{object.send(attribute).gsub(/[^0-9A-Za-z\-_]/, '_')}"
rescue
  if object.respond_to?('id')
    "#{object.class.to_s.downcase}_#{object.id}"
  else
    "#{object.class.to_s.downcase}_#{object.to_s.gsub(/[^0-9A-Za-z\-_]/, '_')}"
  end
end
