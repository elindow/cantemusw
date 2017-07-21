class AddNoteToSinger < ActiveRecord::Migration[5.0]
  def change
    add_column :singers, :notes, :text
  end
end
