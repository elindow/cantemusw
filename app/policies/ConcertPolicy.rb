class ConcertPolicy < ApplicationPolicy

	def update?
		user.admin?
	end
end