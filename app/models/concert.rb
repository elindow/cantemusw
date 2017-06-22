class Concert < ApplicationRecord
	has_and_belongs_to_many :singers
	has_and_belongs_to_many :songs 
end
