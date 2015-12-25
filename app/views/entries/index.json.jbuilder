json.array!(@entries) do |entry|
  json.extract! entry, :id, :location, :rating, :content
  json.url entry_url(entry, format: :json)
end
