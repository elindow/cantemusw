json.extract! singer, :id, :lastName, :firstName, :email, :voice, :joined, :left, :created_at, :updated_at
json.url singer_url(singer, format: :json)
