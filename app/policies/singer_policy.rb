class SingerPolicy < ApplicationPolicy

	def show?
		user?
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

  class Scope < Scope
    def resolve
      scope
    end
  end
end
