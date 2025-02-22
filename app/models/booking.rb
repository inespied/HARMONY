class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :portfolio
  enum status: { pending: 'pending', accepted: 'accepted', cancelled: 'cancelled', declined: 'declined' }

  validates :start_date, :end_date, :portfolio_id, presence: true
  validate :end_date_after_start_date
  scope :by_user, ->(user) { where(user: user) }
  scope :by_portfolio, ->(portfolio) { where(portfolio: portfolio) }

  # Définit le statut par défaut à "pending"
  after_initialize :set_default_status, if: :new_record?

  # Calcul du prix avant la sauvegarde
  before_save :calculate_total_price

  private

  # Méthode pour définir le statut par défaut
  def set_default_status
    self.status ||= :pending
  end

  # Méthode pour calculer le prix total
  def calculate_total_price
    if start_date && end_date
      self.total_price = self.class.calculate_price(start_date, end_date, portfolio.price_per_day)
    end
  end

  # Méthode pour calculer le prix
  def self.calculate_price(start_date, end_date, price_per_day)
    return 0 if start_date.nil? || end_date.nil? || end_date <= start_date
    days = (end_date - start_date).to_i
    days * price_per_day
  end

  # Validation pour vérifier que la date de fin est postérieure à la date de début
  def end_date_after_start_date
    if end_date <= start_date
      errors.add(:end_date, "doit être postérieure à la date de début")
    end
  end
end
