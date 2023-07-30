class CreateTreasureHunts < ActiveRecord::Migration[7.0]
  def change
    create_table :treasure_hunts do |t|
      t.references :team, null: false, foreign_key: true
      t.string :name
      t.datetime :starts_at
      t.datetime :ends_at
      t.text :call_to_action
      t.text :incentive
      t.boolean :allow_image, default: false
      t.string :token

      t.timestamps
    end
  end
end
