class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    @portfolios = Portfolio.all
  end

  def dashboard

      "ceci est le dashboard"
    #afficher les portoflios attribués au user

    #afficher les bookings attribués au user
  end
end
