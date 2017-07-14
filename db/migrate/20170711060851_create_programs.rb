class CreatePrograms < ActiveRecord::Migration[5.0]
  def change
    create_table :programs do |t|
      t.references :concert, comment: 'concert id for given song'
      t.references :song, comment: 'song id for given concert'

      t.integer :song_order, comment: 'Stores the order of songs in this concert'

      t.timestamps
    end
  end
end
