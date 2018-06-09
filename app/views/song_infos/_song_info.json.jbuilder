json.extract! song_info, :id, :search_by, :website, :status, :web_template, :user_id, :created_at, :updated_at
json.url song_info_url(song_info, format: :json)
