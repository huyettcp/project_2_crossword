class AddWordIdToPhotos < ActiveRecord::Migration
  def up
    add_column :photos, :word_id, :integer
  end
  def down
    remove_column :photos, :word_id
  end
end


