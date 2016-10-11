class BuysController < ApplicationController
  require 'mercadopago.rb'
  require 'mercadopago-api.rb'

  def create
  		mp = MercadoPago.new('8060680399806762', 'vY9wVUceuL3VHNqu3cEgpdCtTWBosIlC')
  		preferenceData = {
  			:items =>
  				[
  					:title=>"Multicolor kite",
  					:quantity=>1,
  					:unit_price=>10.0,
            :category_id=>"art",
  					:currency_id=>"ARS" # Available currencies at: https://api.mercadopago.com/currencies
  				]

  		}
  		preference = mp.create_preference(preferenceData)

respond_to do |format|
      format.html { redirect_to turns_path, notice: preference['response']['init_point']}
format.json { render :show, status: :created, location: @buy }
end

  	end




  def index
    @buys = Buy.where(user_id: (current_user)).all
  end

  def create2
    buys_params={ :credit=> 2,
                  :user_id => current_user.id}
    @buy = Buy.new(buys_params)
    respond_to do |format|
      if @buy.save
        format.json { render :show, status: :created, location: @buy }
      else
        format.html { render :new }
        format.json { render json: @buy.errors, status: :unprocessable_entity }
      end
    end
  end
end
