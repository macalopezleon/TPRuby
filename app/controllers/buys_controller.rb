class BuysController < ApplicationController
  require 'mercadopago.rb'
  skip_before_action :verify_authenticity_token
  client_id='8060680399806762'
  client_secret='vY9wVUceuL3VHNqu3cEgpdCtTWBosIlC'

  def create
    $mp = MercadoPago.new('8060680399806762','vY9wVUceuL3VHNqu3cEgpdCtTWBosIlC')
    $mp.sandbox_mode(true)


    cantidad=params[:cant].to_i
    $preferenceData = {
      :items =>
      [
        :title=>"Credits",
        :quantity=>cantidad,
        :unit_price=>10.0,
        :category_id=>"art",
        :currency_id=>"ARS" # Available currencies at: https://api.mercadopago.com/currencies
      ]

    }
    $preference = $mp.create_preference($preferenceData)
    puts $preference
#    AT=`curl -s -X POST -H 'content-type: application/x-www-form-urlencoded' 'https://api.mercadopago.com/oauth/token' -d 'grant_type=client_credentials' -d 'client_id=8060680399806762' -d 'client_secret=vY9wVUceuL3VHNqu3cEgpdCtTWBosIlC' | grep -o '"access_token":"[^"]*"' | sed -n 's/.*"access_token":"\(.*\)"/\1/p'`
#
  #  curl -X POST \
  #  -H "Content-Type: application/json" \
#    "https://api.mercadopago.com/users/test_user?access_token=$AT" \
  #  -d '{"site_id":"MLA"}'

    paymentData = Hash[
      "transaction_amount" => 100,
      "description" => "Title of what you are paying for",
      "payment_method_id" => "rapipago",
      "payer" => Hash[
        "email" => "test_user_37653740@testuser.com"
      ]
    ]
    payment = $mp.post("/v1/payments", paymentData)

    if payment["status"] == "200"
      puts payment
      puts "entro"
    else
      puts "nada"
    end

    buys_params={ :credit=>params[:cant],
      :idMP => $preference["response"]["id"],
      :user_id => current_user.id}
      @buy = Buy.new(buys_params)
      respond_to do |format|
        if @buy.save
          format.html { redirect_to buys_path, notice: 'Se ha realizado la compra existosamente' }
          format.json { render :show, status: :created, location: @buy }
        else
          format.html { render :new }
          format.json { render json: @buy.errors, status: :unprocessable_entity }
        end
      end
    end

    puts $preferenceResult

    def index
      @buys = Buy.where(user_id: (current_user)).all
    end

    def show
    end


  end
