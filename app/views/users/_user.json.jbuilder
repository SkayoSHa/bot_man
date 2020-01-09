json.id user.id
json.email user.email
json.isSignedIn true

if @includeToken
  json.token user.generate_jwt
end
