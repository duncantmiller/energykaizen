class CreateIdeaResponses < ActiveRecord::Migration[7.0]
  def change
    create_table :idea_responses do |t|
      t.references :attempt, null: false, foreign_key: true
      t.references :idea, null: false, foreign_key: true
      t.string :value
      t.text :comment

      t.timestamps
    end
  end
end
