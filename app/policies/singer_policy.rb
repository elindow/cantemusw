class SingerPolicy < ApplicationPolicy

	def show?
		user?
	end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
