class UsersController < ApplicationController
  def my_portfolio
    @tracked_stock = current_user.stocks #many to many association
  end

  def my_friends
    @friends=current_user.friends

  end

  def search
    
    if params[:friend].present?   
      @friends = User.search(params[:friend])
      if @friends
              respond_to do |format|
              format.js{ render partial:'users/friend_result' }
         end
      else
          respond_to do |format|
          flash.now[:alert]="Couldn't find user with this name"
          format.js{ render partial: 'users/friend_result'}
          end
      end
  else
      respond_to do |format|
          flash.now[:alert]="Please enter valid name or email"
          format.js{ render partial: 'users/friend_result'}
          end
  end    
end
end
  

