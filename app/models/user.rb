class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :friendships
  has_many :friends, through: :friendships
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

  def full_name
    return "#{first_name} #{last_name}" if first_name || last_name
    "Anonymous"
  end
  
  def self.search(params)
    params.strip!
    to_send_back= (first_name_match(params) + last_name_match(params) + email_match(params)).uniq
    return nil unless to_send_back
    to_send_back
  end
  
  def self.first_name_match(params)
    match('first_name',params)
  end

  def self.last_name_match(params)
    match('last_name',params)
  end

  def self.email_match(params)
    match('email',params)
  end
  
  def self.match(field_name, params)
    where(" #{field_name} like ?", "%#{params}%")
  end

  def not_friends_with?(friend_id)
    !self.friends.where(id: friend_id).exists?
  end
        
end
