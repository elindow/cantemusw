class ConcertPolicy < ApplicationPolicy

	def show?
		if user.nil? 
			false
		else
			true
		end
	end
	

	def create?
		if user.nil? 
			false
		else
			user.admin?
		end
	end

	def update?
		if user.nil? 
			false
		else
			user.admin?
		end
	end


end