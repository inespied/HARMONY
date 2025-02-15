class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :portfolio
  enum status: { pending: 'pending', accepted: 'accepted', cancelled: 'cancelled', declined: 'declined' }
end
