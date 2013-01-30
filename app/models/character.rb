class Character < ActiveRecord::Base
  attr_accessible :age, :conflict, :description, :name
  validates :name, :presence=>true
  validates :name, :uniqueness=>true
  validates :age, :numericality => true

  def dom_name
    return 'character_'+self.name.gsub(/[^0-9A-Za-z_\-]/, "_")
  end
end
