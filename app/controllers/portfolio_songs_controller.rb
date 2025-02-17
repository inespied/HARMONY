class PortfolioSongsController < ApplicationController
  def new
    @portfolio = Portfolio.find(params[:portfolio_id])
    @portfolio_song = PortfolioSong.new
  end

  def create
    @portfolio = Portfolio.find(params[:portfolio_id])
    @portfolio_song = PortfolioSong.new(portfolio_song_params)
    @portfolio_song.portfolio = @portfolio
    if @portfolio_song.save
      redirect_to portfolio_path(@portfolio)
    else   
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @portfolio = Portfolio.find(params[:portfolio_id])
    @portfolio_song = PortfolioSong.find(params[:id])
    @portfolio_song.destroy
    redirect_to portfolio_path(@portfolio)
  end

  private

  def portfolio_song_params
    params.require(:portfolio_song).permit(:portfolio, :song_id)
  end
end
