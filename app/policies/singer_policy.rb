class SingerPolicy < ApplicationPolicy

	def index?
		true
	end

	def index?
		true
	end

	def show?
		true
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

	def destroy?
    	user.admin?
  	end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
