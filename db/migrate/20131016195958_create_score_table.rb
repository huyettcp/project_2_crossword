class CreateScoreTable < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.integer :game_score

      t.timestamps
    end
  end
end
