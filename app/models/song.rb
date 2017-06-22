class Song < ApplicationRecord
	has_and_belongs_to_many :concerts
	has_and_belongs_to_many :singers
end
