# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# def check_birth_date
#     users = User.all
#     users.each do |user|
#         user.points.create(point: 100) if user.date_of_birth == Date.today
#     end
# end

# 100.times do
#     Purchase.create(user_id: 1, product_id: 3, price: 100)
# end

10.times do
    Point.create(user_id:3 , point: 100)
end