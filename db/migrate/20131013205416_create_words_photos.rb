class CreateWordsPhotos < ActiveRecord::Migration
  def change
    create_table :photos_and_words, id: false do |t|
      t.integer :photo_id
      t.integer :word_id
    end
  end

end
