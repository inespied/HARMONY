class PortfoliosController < ApplicationController
  def index
    @portfolios = Portfolio.all
  end

  def new
    @portfolio = Portfolio.new
  end

  def create
    @new_portfolio = Portfolio.new(portfolio_params)
    @new_portfolio.user = current_user
    if @new_portfolio.save
      redirect_to portfolio_path(@new_portfolio), notice: "Playlist créée avec succès !"
    else
      # On réaffiche la modal => on peut re-render la vue qui contient la partial
      # par exemple, si on était sur la home ou la show, on refait un render :index ou :show
      # Mais pour un code simple :
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @portfolio = Portfolio.find(params[:id])
    @songs = @portfolio.songs
    @portfolio_song = @portfolio.portfolio_songs.build
  end

  def destroy
    @portfolio = Portfolio.find(params[:id])
    @portfolio.destroy
    redirect_to portfolios_path
  end

  def edit
    @portfolio = Portfolio.find(params[:id])
  end

  def update
    @portfolio = Portfolio.find(params[:id])
    @portfolio.update(portfolio_params)
    redirect_to portfolio_path(@portfolio)
  end

  private

  def portfolio_params
    params.require(:portfolio).permit(:title, :tags, :price_per_day, :photo)
  end
end
