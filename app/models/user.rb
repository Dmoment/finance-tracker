class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :user_stocks
  has_many :stocks, through: :user_stocks
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
         
  def stocks_already_tracked?(ticker_symbol)
    stock= Stock.check_db(ticker_symbol) #Ensures whether the stock is already there in database
    return false unless stock
    stocks.where(id: stock.id).exists?# Ensures whether the current user is associated with this stock.

  end

  def stock_under_limit?
    stocks.count < 10
  end

  def can_track_stock?(ticker_symbol)
    stock_under_limit? && !stocks_already_tracked?(ticker_symbol)
  end
        
end
