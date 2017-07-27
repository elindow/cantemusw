class AddImageToSinger < ActiveRecord::Migration[5.0]
  def change
    add_column :singers, :image_data, :text
  end
end
