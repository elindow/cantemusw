class AddConcertYearToConcert < ActiveRecord::Migration[5.0]
  def change
  	add_column :concerts, :concert_year, :integer
  end
end
