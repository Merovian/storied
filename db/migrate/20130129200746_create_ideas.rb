class CreateIdeas < ActiveRecord::Migration
  def change
    create_table :ideas do |t|
      t.string :name
      t.text :description
      t.text :mentality
      t.text :start_state
      t.text :end_state
      t.string :type

      t.timestamps
    end
  end
end
