class CreateJoinTableConcertsSingers < ActiveRecord::Migration[5.0]
  def change
    create_join_table :concerts, :singers do |t|
      # t.index [:concert_id, :singer_id]
      # t.index [:singer_id, :concert_id]
    end
  end
end
