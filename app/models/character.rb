class Character < ActiveRecord::Base
  attr_accessible :age, :conflict, :description, :name
  validates :name, :presence=>true
  validates :age, :numericality => true
end
