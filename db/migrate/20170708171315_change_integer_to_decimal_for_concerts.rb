class ChangeIntegerToDecimalForConcerts < ActiveRecord::Migration[5.0]
 	def change
  		change_column :concerts, :concert_year, :decimal, :precision => 6, :scale => 2
 	end
 end
