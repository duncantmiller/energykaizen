class AddSlotToIdeaAndHuntTopic < ActiveRecord::Migration[7.0]
  def change
    add_column :ideas, :slot, :integer
    add_column :hunt_topics, :slot, :integer
  end
end
