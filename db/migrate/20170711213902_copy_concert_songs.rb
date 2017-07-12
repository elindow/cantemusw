class CopyConcertSongs < ActiveRecord::Migration[5.0]
	class Concert < ActiveRecord::Base
		has_and_belongs_to_many :songs
		has_many :programs
		has_many :songs, :through => :programs
	end

	class Song < ActiveRecord::Base
		has_and_belongs_to_many :concerts
		has_many :programs
		has_many :concerts, :through => :programs
	end

  def change
  	Concert.find_each do |concert|
  		puts 
  		concert.programs = concert.songs
  	end
  end
end
