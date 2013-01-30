def dom_name(object, attribute)
  "#{object.class.to_s.downcase}_#{object.send(attribute).gsub(/[^0-9A-Za-z\-_]/, '_')}"
end
