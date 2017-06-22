class CreateJoinTableConcertsSongs < ActiveRecord::Migration[5.0]
  def change
    create_join_table :concerts, :songs do |t|
      # t.index [:concert_id, :song_id]
      # t.index [:song_id, :concert_id]
    end
  end
end
