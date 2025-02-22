class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home
  include Pundit

  def home
    @portfolios = Portfolio.all
    @portfolio = Portfolio.first
  end

  def dashboard
    #afficher les portoflios attribués au user
    @portfolios = Portfolio.where(user: current_user)

    #afficher les bookings attribués au user
    @bookings = Booking.where(user: current_user)
  end
end
