class BookingPolicy < ApplicationPolicy
  def create?
    # Autorise la création d'une réservation si l'utilisateur est le propriétaire du portfolio
    record.portfolio.user != user
  end

  def update?
    # Seul l'utilisateur qui a créé la réservation peut la mettre à jour
    record.user == user
  end

  def destroy?
    # Seul l'utilisateur ayant créé la réservation peut la supprimer
    record.user == user
  end

  def accept?
    # Seul le propriétaire du portfolio peut accepter une réservation
    record.portfolio.user == user
  end

  def decline?
    # Seul le propriétaire du portfolio peut refuser une réservation
    record.portfolio.user == user
  end

  def cancel?
    # L'utilisateur qui a créé la réservation peut l'annuler
    record.user == user
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      # Restreindre l'accès aux réservations créées par l'utilisateur actuel
      scope.where(user: user)
    end
  end
end
