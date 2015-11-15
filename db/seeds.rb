# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



cat1 = Category.create(name: "TV Show Comedy") 
cat2 = Category.create(name: "TV Show Drama")
cat3 = Category.create(name: "TV Show Action")

vid1 = Video.create(title: "Monk", description: "Monk tv show.", category: cat2, small_cover_url: "/tmp/monk.jpg", large_cover_url: "/tmp/monk_large.jpg")
vid2 = Video.create(title: "Futurama", description: "Futurama tv show.", category: cat1, small_cover_url: "/tmp/futurama.jpg", large_cover_url: "/tmp/futurama.jpg")
vid3 = Video.create(title: "South Park", description: "South Park tv show.", category: cat1, small_cover_url: "/tmp/south_park.jpg", large_cover_url: "/tmp/south_park.jpg")
vid4 = Video.create(title: "Monk", description: "Monk tv show.", category: cat2, small_cover_url: "/tmp/monk.jpg", large_cover_url: "/tmp/monk_large.jpg")
vid5 = Video.create(title: "Futurama", description: "Futurama tv show.", category: cat1, small_cover_url: "/tmp/futurama.jpg", large_cover_url: "/tmp/futurama.jpg")
vid6 = Video.create(title: "South Park", description: "South Park tv show.", category: cat1, small_cover_url: "/tmp/south_park.jpg", large_cover_url: "/tmp/south_park.jpg")
vid7 = Video.create(title: "Monk", description: "Monk tv show.", category: cat2, small_cover_url: "/tmp/monk.jpg", large_cover_url: "/tmp/monk_large.jpg")
vid8 = Video.create(title: "Futurama", description: "Futurama tv show.", category: cat1, small_cover_url: "/tmp/futurama.jpg", large_cover_url: "/tmp/futurama.jpg")
vid9 = Video.create(title: "South Park", description: "South Park tv show.", category: cat1, small_cover_url: "/tmp/south_park.jpg", large_cover_url: "/tmp/south_park.jpg")
vid10 = Video.create(title: "South Park", description: "South Park tv show.", category: cat1, small_cover_url: "/tmp/south_park.jpg", large_cover_url: "/tmp/south_park.jpg")