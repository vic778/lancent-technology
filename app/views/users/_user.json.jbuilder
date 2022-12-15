json.call(user, :id, :email, :date_of_birth, :location, :rule)
json.token user.generate_jwt
