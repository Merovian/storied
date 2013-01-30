require 'spec_helper'

describe Character, 'validations' do
  it { should validate_presence_of :name }
  it { should validate_numericality_of :age }
  it { should validate_uniqueness_of :name }
end

describe Character, '#dom_name' do
  it 'formats the name for use in the DOM' do
    character = Character.new(name: "Dom d'Name")
    dom_name = character.dom_name
    expect(dom_name).to eq "character_Dom_d_Name"
  end
end
