class AddCaptionToSinger < ActiveRecord::Migration[5.0]
  def change
    add_column :singers, :photo1_caption, :string
    add_column :singers, :photo2_caption, :string
  end
end
