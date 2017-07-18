class AddSoToSong < ActiveRecord::Migration[5.0]
  def change
    add_column :songs, :s_o, :integer
  end
end
