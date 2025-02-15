class PortfoliosController < ApplicationController
  def index
    @portfolios = Portfolio.all
  end

  def new
    @portfolio = Portfolio.new
  end

  def create
    @portfolio = current_user.portfolios.new(portfolio_params)
    @portfolio.save
    redirect_to portfolio_path(@portfolio)
  end

  def show
    @portfolio = Portfolio.find(params[:id])
    @songs = @portfolio.songs
  end

  def destroy
    @portfolio = Portfolio.find(params[:id])
    @portfolio.delete
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
    params.require(:portfolio).permit(:title, :tags, :price_per_day)
  end
end
