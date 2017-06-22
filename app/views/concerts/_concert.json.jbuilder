json.extract! concert, :id, :name, :venue, :concertdate, :conductor, :accompanist, :theme, :notes, :created_at, :updated_at
json.url concert_url(concert, format: :json)
