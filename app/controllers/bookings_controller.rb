class BookingsController < ApplicationController
  before_action :set_booking, only: [:cancel, :accept, :decline]

  def new
    @portfolio = Portfolio.find(params[:portfolio_id])
    @booking = Booking.new
  end

  def create
    @portfolio = Portfolio.find(params[:portfolio_id])
    @booking = @portfolio.bookings.new(booking_params)
    @booking.user = current_user
    @booking.status = "pending"

    if @booking.save
      redirect_to @portfolio, notice: "Demande créée avec succès."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def cancel
    if @booking.pending?
      @booking.cancelled!
      redirect_to @booking.portfolio, notice: "Demande annulée."
    else
      redirect_to @booking.portfolio, alert: "Cette demande ne peut pas être annulée."
    end
  end

  def accept
    if @booking.pending?
      @booking.accepted!
      redirect_to @booking.portfolio, notice: "Demande acceptée."
    else
      redirect_to @booking.portfolio, alert: "Cette demande ne peut pas être acceptée."
    end
  end

  def decline
    if @booking.pending?
      @booking.declined!
      redirect_to @booking.portfolio, notice: "Demande refusée."
    else
      redirect_to @booking.portfolio, alert: "Cette demande ne peut pas être refusée."
    end
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :total_price)
  end
end
