class AddNarratorsToConcert < ActiveRecord::Migration[5.0]
  def change
    add_column :concerts, :narrators, :string
  end
end
