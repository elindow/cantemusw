class CreateConcerts < ActiveRecord::Migration[5.0]
  def change
    create_table :concerts do |t|
      t.string :name
      t.string :venue
      t.date :concertdate
      t.string :conductor
      t.string :accompanist
      t.text :theme
      t.text :notes

      t.timestamps
    end
  end
end
