class AddPhotoToSinger < ActiveRecord::Migration[5.0]
  def change
    add_column :singers, :photo_data, :text
  end
end
