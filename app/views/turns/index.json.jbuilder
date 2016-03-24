json.array!(@turns) do |turn|
  json.extract! turn, :id, :date, :booking
  json.url turn_url(turn, format: :json)
end
