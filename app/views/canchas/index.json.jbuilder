json.array!(@canchas) do |cancha|
  json.extract! cancha, :id, :name, :size, :price, :]
  json.url cancha_url(cancha, format: :json)
end
