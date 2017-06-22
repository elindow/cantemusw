class ChangeColumnName < ActiveRecord::Migration[5.0]
  def change
  	rename_column :songs, :type, :songType
  end
end
