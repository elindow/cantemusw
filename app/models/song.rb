class Song < ApplicationRecord
	has_many :programs
	has_many :concerts, :through => :programs
	accepts_nested_attributes_for :programs


	has_and_belongs_to_many :singers
	#has_and_belongs_to_many :songs
end
