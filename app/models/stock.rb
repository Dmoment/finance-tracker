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

    def self.open_time(ticker_symbol)
        client = IEX::Api::Client.new(
        publishable_token: Rails.application.credentials.dig(:sandbox_api_key),
        secret_token: 'Tsk_344e895a27c741bcbc4da9175df09166',
        endpoint: 'https://sandbox.iexapis.com/v1')
        begin
            open_time=client.intraday_prices(ticker_symbol)
            return open_time
        rescue => exception
            return nil    
        end

    end

    def self.check_db(ticker_symbol)
        where(ticker: ticker_symbol).first
    end

    def self.update_price_column() 
        result=Stock.all
        result.each do |stock|
            client = IEX::Api::Client.new(
                publishable_token: Rails.application.credentials.dig(:sandbox_api_key),
                secret_token: 'Tsk_344e895a27c741bcbc4da9175df09166',
                endpoint: 'https://sandbox.iexapis.com/v1')
                begin
                    price=client.price(stock.ticker)
                    update(last_price: price)
                rescue => exception
                    return nil    
                end 
            end
    end
end