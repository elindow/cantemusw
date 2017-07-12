class CopyConcertSongs < ActiveRecord::Migration[5.0]

  def change
  	Concert.transaction do
  		Concert.find_each do |concert|
  			concert.songs = concert.dep_songs
  		end
  	end
  end

end
