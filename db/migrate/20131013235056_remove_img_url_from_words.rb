class RemoveImgUrlFromWords < ActiveRecord::Migration
  def change
    remove_column :words, :image_url
  end
end
