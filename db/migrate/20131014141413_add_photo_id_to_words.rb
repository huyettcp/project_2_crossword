class AddPhotoIdToWords < ActiveRecord::Migration
  def up
    add_column :words, :photo_id, :integer
  end

  def down
    remove_column :words, :photo_id
  end
end
