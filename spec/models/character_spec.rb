require 'spec_helper'

describe Character, 'validations' do
  it { should validate_presence_of :name }
  it { should validate_numericality_of :age }
  it { should validate_uniqueness_of :name }
end

