json.extract! user, :id, :created_at, :updated_at
json.url users_url(user, format: :json)
json.token user.generate_jwt
