class CreateCharacters < ActiveRecord::Migration
  def change
    create_table :characters do |t|
      t.string :name
      t.integer :age
      t.string :description
      t.string :conflict

      t.timestamps
    end
  end
end
