class PortfolioPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.present? && user.admin?
        scope.all # 🔥 Si admin, voir tous les portfolios
      elsif user.present?
        scope.where(user: user) # Sinon, voir seulement ses propres portfolios
      else
        scope.none # 🔥 Pour éviter que les visiteurs non connectés ne voient des portfolios
      end
    end
  end

  def show?
    record.user == user || user.admin?
  end
  def edit?
    record.user == user || user.admin?
  end

  def update?
    record.user == user || user.admin?
  end

  def destroy?
    record.user == user || user.admin?
  end

end
