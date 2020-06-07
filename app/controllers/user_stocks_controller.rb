class UserStocksController < ApplicationController
    def create
      stock= Stock.check_db(params[:ticker])
      if !stock
         stock= Stock.new_lookup(params[:ticker])
         stock.save #As soon as this will hit the database i.e. stocktable an id will be generated of the record
      end
         @user_stock= UserStock.create(user: current_user, stock: stock)#In the stock entry we will put the above id through passing stock object
         flash[:success]="Your stock #{stock.name} is added successfully"
         redirect_to my_portfolio_path
         
    end

    def destroy
      stock = Stock.find(params[:id])#first fetch stock_id from Stock table
      user_stock= UserStock.where(user_id: current_user.id, stock_id: stock.id).first #first- will extract the object from the resulted association.
      user_stock.destroy
      flash[:notice]="#{stock.ticker} has been destroyed successfully"
      redirect_to my_portfolio_path
    end
    
end
