class Song < ApplicationRecord
	has_many :programs
	has_many :concerts, :through => :programs

	has_and_belongs_to_many :singers
	#has_and_belongs_to_many :songs

	attr_accessor :s_o1, :s_o2, :s_o3
end
