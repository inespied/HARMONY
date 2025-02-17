class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    @portfolios = Portfolio.all
    @portfolio = Portfolio.first
  end

  def dashboard
    #afficher les portoflios attribués au user
    @portfolios = Portfolio.all

    #afficher les bookings attribués au user
    @bookings = Booking.all
  end
end
