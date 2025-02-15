class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :cancel, :accept, :decline]  # Aucune action 'new' ici
  before_action :set_portfolio, only: [:new, :create, :index]

  def index
    @bookings = @portfolio.bookings
  end

  def show
    @booking = Booking.find(params[:id])
    @portfolio = @booking.portfolio
  end

  def new
    # @portfolio = Portfolio.find(params[:portfolio_id])
    @booking = Booking.new
  end

  def create
    @booking = @portfolio.bookings.build(booking_params)
    @booking.user = current_user
  if @booking.save
    puts "Booking saved!"
    redirect_to portfolio_booking_path(@portfolio, @booking), notice: "Réservation créée avec succès."
  else
    puts "Booking NOT saved! Errors: #{@booking.errors.full_messages}"
    flash.now[:alert] = @booking.errors.full_messages.join(", ")
    render :new, status: :unprocessable_entity
    end
  end

  def cancel
    if @booking.pending?
      @booking.update(status: "cancelled")  # Mettre à jour le statut de la demande
      redirect_to portfolio_path(@portfolio), notice: 'Demande annulée avec succès.'
    else
      redirect_to portfolio_path(@portfolio), alert: 'La demande ne peut pas être annulée.'
    end
  end

  def accept
    if @booking.pending?
      @booking.update(status: "accepted")  # Mettre à jour le statut de la demande
      redirect_to portfolio_path(@portfolio), notice: 'Demande acceptée.'
    else
      redirect_to portfolio_path(@portfolio), alert: 'La demande ne peut pas être acceptée.'
    end
  end


  def decline
    if @booking.pending?
      @booking.update(status: "declined")  # Mettre à jour le statut de la demande
      redirect_to portfolio_path(@portfolio), notice: 'Demande refusée.'
    else
      redirect_to portfolio_path(@portfolio), alert: 'La demande ne peut pas être refusée.'
    end
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :price)
  end

  def set_portfolio
    @portfolio = Portfolio.find(params[:portfolio_id])
  end
end
