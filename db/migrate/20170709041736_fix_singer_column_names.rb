class FixSingerColumnNames < ActiveRecord::Migration[5.0]
  def change
  	rename_column(:singers, :firstName, :first_name)
  	rename_column(:singers, :lastName, :last_name)
  end
end
