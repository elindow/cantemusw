class CreateSongs < ActiveRecord::Migration[5.0]
  def change
    create_table :songs do |t|
      t.string :name
      t.string :source
      t.string :composer
      t.string :lyricist
      t.string :genre
      t.string :type

      t.timestamps
    end
  end
end
