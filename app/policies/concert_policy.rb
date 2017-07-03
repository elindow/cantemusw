class ConcertPolicy < ApplicationPolicy

	def update?
		if user.nil? 
			false
		else
			user.admin?
		end
	end
end