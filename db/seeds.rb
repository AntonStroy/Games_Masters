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
  AdminUser.create!(email: "admin@example.com", password: "password", password_confirmation: "password")
end

games_csv = Rails.root + "db/games.csv"
games = SmarterCSV.process(games_csv, { col_sep: "\t" })
games_descriptions_csv = Rails.root + "db/games_description.csv"
games_descriptions = SmarterCSV.process(games_descriptions_csv, { col_sep: "\t" })
games_covers_csv = Rails.root + "db/games_covers.csv"
games_covers = SmarterCSV.process(games_covers_csv, { col_sep: "\t" })
sku = 10_001
# Games columns
# appid	name release_date	english	developer	publisher	categories	genres	price
# Games_description columns
# steam_appid	short_description
# Games_covers columns
# steam_appid	header_image
games[0..150].each do |g|
  game_dedscription = ""
  games_descriptions.each do |d|
    if d["steam_appid"] == g["appid"]
      game_dedscription = d["short_description"]
      break
    end
  end
  game_cover = ""
  games_covers.each do |c|
    if c["steam_appid"] == g["appid"]
      game_cover = c["header_image"]
      break
    end
  end

  developer = Developer.find_or_create_by(name: g["developer"])
  publisher = Publisher.find_or_create_by(name: g["publisher"])
  Game = Product.find_or_create_by(sku:          sku + 1,
                                   name:         g["name"],
                                   description:  g["description"],
                                   release_date: g["release_date"],
                                   price:        g["price"],
                                   stock:        rand(1..50))
  cover = open(URI.escape("https://steamcdn-a.akamaihd.net/steam/apps/#{g[:appid]}/header.jpg"))
  game.avatar.attach(io: cover, filename: "m-#{game.name}.jpg")
  sleep(1)

  genres = g["genres"].split(";")
  genres.each do |one_genre|
    genre = Genre.find_or_create_by(name: one_genre)
    GenreProduct.create(genre: genre, product: Game)
  end
end

puts "Seed file genarate #{Game.count} Games"
puts "Seed file genarate #{Developer.count} Developers"
puts "Seed file genarate #{Publisher.count} Publishers"
puts "Seed file genarate #{Genre.count} Genres"
puts "Seed file genarate #{GenreProduct.count} GenreProduct"
