class Stock < ApplicationRecord
    has_many :user_stocks
    has_many :users, through: :user_stocks
    validates :name, :ticker, presence: true
    def self.new_lookup(ticker_symbol)
        
        client = IEX::Api::Client.new(
        publishable_token: Rails.application.credentials.dig(:sandbox_api_key),
        secret_token: 'Tsk_344e895a27c741bcbc4da9175df09166',
        endpoint: 'https://sandbox.iexapis.com/v1')
        begin
        company= client.company(ticker_symbol).company_name
        price=client.price(ticker_symbol)
        @key_stats = client.key_stats('MSFT')
        new(ticker: ticker_symbol, name: company, last_price: price)
        rescue => exception
            return nil
        end    
        
    end

    def self.stock_stats(ticker_symbol)
        client = IEX::Api::Client.new(
        publishable_token: Rails.application.credentials.dig(:sandbox_api_key),
        secret_token: 'Tsk_344e895a27c741bcbc4da9175df09166',
        endpoint: 'https://sandbox.iexapis.com/v1')
        begin
            key_stats=client.key_stats(ticker_symbol)
            return key_stats
        rescue => exception
            return nil    
        end

    end

    def self.check_db(ticker_symbol)
        where(ticker: ticker_symbol).first
    end
end