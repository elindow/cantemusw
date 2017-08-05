class AddSubmittedByToPicture < ActiveRecord::Migration[5.0]
  def change
    add_column :pictures, :submitted_by, :string
  end
end
