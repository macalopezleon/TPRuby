class MercadopagoController < ApplicationController
  require 'mercadopago.rb'

  $mp = MercadoPago.new('8060680399806762', 'vY9wVUceuL3VHNqu3cEgpdCtTWBosIlC')

  $accessToken = $mp.getAccessToken()

  puts ($accessToken)

  preference_data = {
              "items": [
                  {
                      "title": "testCreate",
                      "quantity": 1,
                      "unit_price": 10.2,
                      "currency_id": "ARS"
                  }
              ]
          }
  preference = $mp.create_preference(preference_data)

  puts preference


end
