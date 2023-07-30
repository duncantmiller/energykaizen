class CreateHuntTopics < ActiveRecord::Migration[7.0]
  def change
    create_table :hunt_topics do |t|
      t.string :name

      t.timestamps
    end
  end
end
