class AddUserNameToScores < ActiveRecord::Migration
  def change
    add_column :scores, :user_name, :string
  end
end
