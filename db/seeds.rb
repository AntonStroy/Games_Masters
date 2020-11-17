require "csv"

GenreGame.destroy_all
PlatformGame.destroy_all
Genre.destroy_all
Platform.destroy_all
Order.destroy_all
Game.destroy_all
OrderGame.destroy_all
Publisher.destroy_all
Developer.destroy_all
Account.destroy_all
User.destroy_all
Province.destroy_all
AdminUser.destroy_all
if Rails.env.development?
  AdminUser.create!(email: "admin@example.com", password: "password", password_confirmation: "password")
end

games_csv = Rails.root + "db/games.csv"
games = SmarterCSV.process(games_csv, { col_sep: "\t" })
games_descriptions_csv = Rails.root + "db/games_descriptions.csv"
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
games[26_900..27_200].each do |g|
  sku += 1
  game_description = ""
  games_descriptions.each do |d|
    if d[:steam_appid] == g[:appid]
      game_description = d[:short_description]
      break
    end
  end
  game_cover = ""
  games_covers.each do |c|
    if c[:steam_appid] == g[:appid]
      game_cover = c[:header_image]
      break
    end
  end

  developer = Developer.find_or_create_by(name: g[:developer])
  publisher = Publisher.find_or_create_by(name: g[:publisher])

  game = Game.find_or_create_by(sku:          sku,
                                name:         g[:name],
                                description:  game_description,
                                release_date: g[:release_date],
                                price:        g[:price],
                                stock:        rand(1..50),
                                developer:    developer,
                                publisher:    publisher,
                                cover:        game_cover)

  genres = g[:genres].split(";")
  genres.each do |one_genre|
    genre = Genre.find_or_create_by(name: one_genre)
    GenreGame.create(genre: genre, game: game)
  end

  copy_cover = open(URI.escape("https://steamcdn-a.akamaihd.net/steam/apps/#{g[:appid]}/header.jpg"))
  game.cover.attach(io: copy_cover, filename: "m-#{game.name}.jpg")
  sleep(1)
end

puts "Seed file genarated #{Developer.count} Developers"
puts "Seed file genarated #{Publisher.count} Publishers"
puts "Seed file genarated #{Game.count} Games"
puts "Seed file genarated #{Genre.count} Genres"
puts "Seed file genarated #{GenreGame.count} GenreGames"
