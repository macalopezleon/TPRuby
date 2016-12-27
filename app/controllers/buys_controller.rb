class BuysController < ApplicationController
  require 'mercadopago.rb'
  skip_before_action :verify_authenticity_token

  def create
    if !(params[:cant].empty?)
    $mp = MercadoPago.new(Rails.configuration.secrets['CLIENT_ID'],Rails.configuration.secrets['CLIENT_SECRET'])
    $mp.sandbox_mode(true)


    cantidad=params[:cant].to_i
    $preferenceData = {
      :items =>
      [
        :title=>"Credits",
        :quantity=>cantidad,
        :unit_price=>Rails.configuration.global['CREDIT_PRICE'],
        :category_id=>"art",
        :currency_id=>"ARS" # Available currencies at: https://api.mercadopago.com/currencies
      ]

    }
    $preference = $mp.create_preference($preferenceData)
    url= $preference['response']['sandbox_init_point']

    p url
    #    if $payment_info["status"] == "200"
    #      puts payment
    #      puts "ingreso"
    #    else
    #      puts "no ingreso"
    #    end

    buys_params={ :credit=>params[:cant],
      :idMP => url,
      :user_id => current_user.id}
    @buy = Buy.new(buys_params)
    credits=current_user.credit+params[:cant].to_i

    respond_to do |format|
      if @buy.save
        @current_user.update_attributes(credit: credits)
        format.html { redirect_to buys_path, notice: url }
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
