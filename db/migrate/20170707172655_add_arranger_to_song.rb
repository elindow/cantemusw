class AddArrangerToSong < ActiveRecord::Migration[5.0]
  def change
  	add_column :songs, :arranger, :string
  	add_column :songs, :notes, :text
  end
end
