class UsersController < ApplicationController
  def create
    name = User.new(params[:user_name])
    if name.save
      render :json => name.to_json
    else
      render :json => false
    end


    
  end

end