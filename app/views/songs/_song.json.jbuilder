json.extract! song, :id, :name, :source, :composer, :lyricist, :genre, :type, :created_at, :updated_at
json.url song_url(song, format: :json)
