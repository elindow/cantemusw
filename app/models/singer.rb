class Singer < ApplicationRecord
	has_and_belongs_to_many :concerts
	has_and_belongs_to_many :songs
end
