<<<<<<< HEAD
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "csv"

Publisher.destroy_all
Developer.destroy_all
Genre.destroy_all
Platform.destroy_all
GenreGame.destroy_all
PlatformGame.destroy_all
Game.dedstroy_all
User.dedstroy_all
Province.destroy_all
Account.destroy_all
OrderGame.destroy_all
Order.destroy_all
AdminUser.destroy_all
if Rails.env.development?
  AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
end

games = Rails
=======
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# <%= image_tag file.preview(resize_to_limit: [100, 100]) %>

AdminUser.delete_all

if Rails.env.development?
  AdminUser.create!(email: "admin@example.com", password: "password", password_confirmation: "password")
end
>>>>>>> active_admin
