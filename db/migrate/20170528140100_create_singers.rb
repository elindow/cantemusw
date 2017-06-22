class CreateSingers < ActiveRecord::Migration[5.0]
  def change
    create_table :singers do |t|
      t.string :lastName
      t.string :firstName
      t.string :email
      t.string :voice
      t.date :joined
      t.date :left

      t.timestamps
    end
  end
end
