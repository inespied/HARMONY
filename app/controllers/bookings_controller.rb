class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :cancel, :accept, :decline, :update, :destroy]
  before_action :set_portfolio, only: [:new, :create, :index]

  def index
    @bookings = @portfolio.bookings
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

  def new
    @portfolio = Portfolio.find(params[:portfolio_id])
    @booking = Booking.new
    puts "Prix par jour dans new : #{@portfolio.price_per_day}"
  end

  def create
    @booking = @portfolio.bookings.build(booking_params)
    @booking.user = current_user

    puts "Prix par jour : #{@portfolio.price_per_day}"
    puts "Date de début : #{@booking.start_date}"
    puts "Date de fin : #{@booking.end_date}"
    puts "Prix total calculé : #{@booking.total_price}"

    if @booking.save
      redirect_to portfolio_booking_path(@portfolio, @booking), notice: "Réservation créée avec succès."
    else
      flash.now[:alert] = @booking.errors.full_messages.join(", ")
      render :new, status: :unprocessable_entity
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
  @booking.update(status: 'accepted')
  redirect_to portfolio_bookings_path(@portfolio), notice: 'Réservation acceptée.'
  end

  def decline
  @booking.update(status: 'declined')
  redirect_to portfolio_bookings_path(@portfolio), notice: 'Réservation déclinée.'
  end

  def cancel
  @booking.update(status: 'canceled')
  redirect_to portfolio_bookings_path(@portfolio), notice: 'Réservation annulée.'
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
    params.require(:booking).permit(:start_date, :end_date, :status, :total_price)
  end

  def set_portfolio
    @portfolio = Portfolio.find(params[:portfolio_id])
  end

  def calculate_price(start_date, end_date, price_per_day)
    return 0 if start_date.nil? || end_date.nil? || end_date <= start_date
    days = (end_date - start_date).to_i
    days * price_per_day
  end

end
