require 'spec_helper'

describe ApplicationHelper, '#dom_name' do
  it 'sets an object attribute value to be useful as a DOM id' do
    c = Character.new(name: "Dom d'Name")
    dom_name(c, 'name').should eql("character_Dom_d_Name")
  end

  it 'does not break on bad attribute name' do
    c = Character.new(name: "Dom d'Name")
    c.save
    dom_name(c, 'xxx').should eql("character_#{c.id}")
  end

  it 'does not break on bad object types' do
    dom_name(123, 'xxx').should eql("fixnum_123")
    dom_name('blah', 'xxx').should eql("string_blah")
    dom_name(123.4, 'xxx').should eql("float_123_4")
  end
end
