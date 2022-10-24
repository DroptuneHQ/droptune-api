# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

artist_1 = Artist.create(name: "The Beatles", slug: "the-beatles", image: "https://upload.wikimedia.org/wikipedia/commons/thumb/4/4f/Beatles_-_Abbey_Road.jpg/1200px-Beatles_-_Abbey_Road.jpg")

artist_2 = Artist.create(name: "The Rolling Stones", slug: "the-rolling-stones", image: "https://upload.wikimedia.org/wikipedia/commons/thumb/0/0b/The_Rolling_Stones_-_1964.jpg/1200px-The_Rolling_Stones_-_1964.jpg")

artist_3 = Artist.create(name: "The Who", slug: "the-who", image: "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3e/The_Who_1975.jpg/1200px-The_Who_1975.jpg")

artist_4 = Artist.create(name: "The Kinks", slug: "the-kinks", image: "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3e/The_Kinks_1964.jpg/1200px-The_Kinks_1964.jpg")