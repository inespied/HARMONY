class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :portfolio
  enum status: { pending: 'pending', accepted: 'accepted', cancelled: 'cancelled', declined: 'declined' }

  # Définit le statut par défaut à "pending"
  after_initialize :set_default_status, if: :new_record?

  # Calcul du prix avant la sauvegarde
  before_save :calculate_total_price

  private

  # Méthode pour définir le statut par défaut
  def set_default_status
    self.status ||= :pending
  end

  # Calcul du prix total
  def calculate_total_price
    if start_date && end_date
      self.total_price = BookingsController.new.send(:calculate_price, start_date, end_date, portfolio.price_per_day)
    end
  end
end
