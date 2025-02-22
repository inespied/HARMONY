class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :cancel, :accept, :decline, :update, :destroy]
  before_action :set_portfolio, only: [:new, :create, :index]
  before_action :authenticate_user!

  def index
    if current_user.portfolio?
      @bookings = @portfolio.bookings
    else
      @bookings = Booking.all  # Pour les autres utilisateurs, ou selon ta logique
    end
  end

  def show
    @booking = Booking.find(params[:id])
    @portfolio = @booking.portfolio
    @price_per_day = @portfolio.price_per_day

    # Assurer que start_date et end_date sont des objets Date
    @start_date = @booking.start_date.to_date if @booking.start_date.present?
    @end_date = @booking.end_date.to_date if @booking.end_date.present?

    # Calculer le prix total
    @total_price = calculate_price(@start_date, @end_date, @price_per_day)
  end
  def view_bookings
    authorize :user, :view_bookings?
    @bookings = current_user.bookings
  end
  def new
    @portfolio = Portfolio.find(params[:portfolio_id])
    @booking = Booking.new
    puts "Prix par jour dans new : #{@portfolio.price_per_day}"
  end

  def create
    @portfolio = Portfolio.find(params[:portfolio_id])
    @booking = @portfolio.bookings.build(booking_params)
    @booking.user = current_user

    if @booking.save
      redirect_to @portfolio, notice: 'Réservation créée avec succès.'
    else
      render :new
    end
  end


  def update
    @booking.total_price = calculate_price(@booking.start_date, @booking.end_date, @portfolio.price_per_day)

    if @booking.update(booking_params)
      redirect_to portfolio_booking_path(@portfolio, @booking), notice: "Réservation mise à jour avec succès."
    else
      render :edit
    end
  end


  def accept
    puts "➡️ accept action appelée !"
    @booking.update(status: 'accepted')
    redirect_to portfolio_bookings_path(@booking.portfolio), notice: 'Réservation acceptée.'
  end



  def decline
    @booking.update(status: 'declined')
    redirect_to portfolio_bookings_path(@booking.portfolio), notice: 'Réservation déclinée.'
  end

  def cancel
    @booking.update(status: 'cancelled')
    redirect_to portfolio_bookings_path(@booking.portfolio), notice: 'Réservation annulée.'
  end

  def destroy
    @booking = Booking.find(params[:id])
    if @booking.destroy
      redirect_to portfolio_bookings_path(@booking.portfolio), notice: "Réservation supprimée."
    else
      redirect_to portfolio_bookings_path(@booking.portfolio), alert: "Erreur lors de la suppression de la réservation."
    end
  end



  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :status, :total_price, :portfolio_id)
  end

  def set_portfolio
    @portfolio = Portfolio.find(params[:portfolio_id])
    # Si le portfolio n'existe pas, rediriger avec un message d'alerte
    unless @portfolio
      redirect_to portfolios_path, alert: "Ce portfolio n'existe pas."
    end
  end


  def calculate_price(start_date, end_date, price_per_day)
    return 0 if start_date.nil? || end_date.nil? || end_date <= start_date
    days = (end_date - start_date).to_i
    days * price_per_day
  end
end
