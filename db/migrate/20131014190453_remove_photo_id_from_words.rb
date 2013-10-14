class RemovePhotoIdFromWords < ActiveRecord::Migration
  def change
    remove_column :words, :photo_id
  end
end
