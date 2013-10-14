class DropPhotosAndWords < ActiveRecord::Migration
  def change
    drop_table :photos_and_words
  end
end
