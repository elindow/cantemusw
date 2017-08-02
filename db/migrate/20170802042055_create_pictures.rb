class CreatePictures < ActiveRecord::Migration[5.0]
  def change
    create_table :pictures do |t|
      t.text :picture_data
      t.string :caption
      t.date :picture_date
      t.text :notes

      t.timestamps
    end
  end
end
