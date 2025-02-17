class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :cancel, :accept, :decline, :update, :destroy]
  before_action :set_portfolio, only: [:new, :create, :index]

  def index
    @bookings = @portfolio.bookings
  end

  def show
    @booking = Booking.find(params[:id])
  @portfolio = @booking.portfolio
  puts "Booking ID: #{@booking.id}"
  puts "Portfolio ID: #{@portfolio.id}"
  @total_price = calculate_price(@booking.start_date, @booking.end_date, @portfolio.price_per_day)
  @price_per_day = @portfolio.price_per_day
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
    @booking.update(booking_params)
    @booking.total_price = calculate_price(@booking.start_date, @booking.end_date, @portfolio.price_per_day)

    if @booking.save
      redirect_to portfolio_booking_path(@portfolio, @booking), notice: "Réservation mise à jour avec succès."
    else
      render :edit
    end
  end

  def cancel
    if @booking.pending?
      @booking.update(status: "cancelled")
      redirect_to portfolio_path(@portfolio), notice: 'Demande annulée.'
    else
      redirect_to portfolio_path(@portfolio), alert: 'La demande ne peut pas être annulée.'
    end
  end

  def accept
    if @booking.pending?
      @booking.update(status: "accepted")
      redirect_to portfolio_path(@portfolio), notice: 'Demande acceptée.'
    else
      redirect_to portfolio_path(@portfolio), alert: 'La demande ne peut pas être acceptée.'
    end
  end

  def decline
    if @booking.pending?
      @booking.update(status: "declined")
      redirect_to portfolio_path(@portfolio), notice: 'Demande refusée.'
    else
      redirect_to portfolio_path(@portfolio), alert: 'La demande ne peut pas être refusée.'
    end
  end
  def destroy
    @booking.destroy
  redirect_to portfolio_bookings_path(@booking.portfolio), notice: "Réservation supprimée."
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
    return 0 if start_date.blank? || end_date.blank? || price_per_day.blank?

    start_date = start_date.to_date if start_date.is_a?(DateTime) || start_date.is_a?(String)
    end_date = end_date.to_date if end_date.is_a?(DateTime) || end_date.is_a?(String)

    return 0 if start_date.nil? || end_date.nil? || end_date <= start_date

    days = (end_date - start_date).to_i
  end
end
