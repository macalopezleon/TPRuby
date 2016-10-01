class BuysController < ApplicationController
  def index
    @buys = Buy.where(user_id: (current_user)).all
  end

  def create
    buys_params={ :credit=> 2,
                  :user_id => current_user.id}
    @buy = Buy.new(buys_params)
    respond_to do |format|
      if @buy.save
        format.html { redirect_to turns_path, notice: 'Buy was successfully.' }
        format.json { render :show, status: :created, location: @buy }
      else
        format.html { render :new }
        format.json { render json: @buy.errors, status: :unprocessable_entity }
      end
    end
  end
end
