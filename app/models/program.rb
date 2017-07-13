class Program < ApplicationRecord
	# validations
	validates_presence_of :concert, :song

	#relations
	belongs_to :concert
	belongs_to :song

end
