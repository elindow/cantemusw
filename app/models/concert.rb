class Concert < ApplicationRecord
	has_and_belongs_to_many :singers

	has_and_belongs_to_many :dep_songs,
		join_table: :concerts_songs, class_name: Song,
		association_foreign_key: :song_id

	has_many :programs
	has_many :songs, :through => :programs
end
