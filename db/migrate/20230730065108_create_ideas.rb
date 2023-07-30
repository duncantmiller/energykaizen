class CreateIdeas < ActiveRecord::Migration[7.0]
  def change
    create_table :ideas do |t|
      t.references :hunt_topic, null: false, foreign_key: true
      t.string :name
      t.string :indicator

      t.timestamps
    end
  end
end
