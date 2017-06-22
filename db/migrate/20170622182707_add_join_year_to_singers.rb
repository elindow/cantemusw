class AddJoinYearToSingers < ActiveRecord::Migration[5.0]
  def change
  	add_column :singers, :join_year, :integer
  	add_column :singers, :left_year, :integer
  end
end
