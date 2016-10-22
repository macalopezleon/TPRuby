class BuysController < ApplicationController
  require 'mercadopago.rb'
  skip_before_action :verify_authenticity_token
  client_id='8060680399806762'
  client_secret='vY9wVUceuL3VHNqu3cEgpdCtTWBosIlC'

  def create
    if !(params[:cant].empty?)
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
    url= $preference['response']['sandbox_init_point']
    id_url= url.split('=')[1]
    #    if $payment_info["status"] == "200"
    #      puts payment
    #      puts "ingreso"
    #    else
    #      puts "no ingreso"
    #    end

    buys_params={ :credit=>params[:cant],
      :idMP => id_url,
      :user_id => current_user.id}
    @buy = Buy.new(buys_params)
    credits=current_user.credit+params[:cant].to_i

    respond_to do |format|
      if @buy.save
        @current_user.update_attributes(credit: credits)
        format.html { redirect_to buys_path, notice: 'Se ha realizado la compra existosamente' }
        format.json { render :show, status: :created, location: @buy }
      else
        format.html { render :new }
        format.json { render json: @buy.errors, status: :unprocessable_entity }
      end
    end
  else
    flash[:notice] = "Debe ingresar la cantidad de creditos que desea comprar"
    redirect_to action: "new"
  end
  end

  def index
    @buys = Buy.where(user_id: (current_user)).all
  end

  def show
  end


end
