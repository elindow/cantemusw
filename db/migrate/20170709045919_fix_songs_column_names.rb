class FixSongsColumnNames < ActiveRecord::Migration[5.0]
  def change
  	rename_column(:songs, :songType, :song_type)
  end
end
