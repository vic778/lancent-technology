json.user do
  json.call(current_user, :id, :email, :date_of_birth)
end
