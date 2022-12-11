# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
(1..100).each do |i|
  Post.create(title: "Title #{i}",
              created_at: Time.now - i.days,
              updated_at: Time.now - i.days,
              views: rand(15..100))
end

(1..20).each do |i|
  Point.create(x: rand(0.0..1.0),
               y: rand(0.0..6.0),
               n: 20)
end