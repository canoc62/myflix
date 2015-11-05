# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


vid1 = Video.create(title: "Monk", description: "Monk tv show.", small_cover_url: "/tmp/monk.jpg", large_cover_url: "/tmp/monk_large.jpg")
vid2 = Video.create(title: "Futurama", description: "Futurama tv show.", small_cover_url: "/tmp/futurama.jpg", large_cover_url: "/tmp/futurama.jpg")
vid3 = Video.create(title: "South Park", description: "South Park tv show.", small_cover_url: "/tmp/south_park.jpg", large_cover_url: "/tmp/south_park.jpg")

cat1 = Category.create(name: "TV Show Comedy") 
cat2 = Category.create(name: "TV Show Drama")
cat3 = Category.create(name: "TV Show Action")

cat1.videos << vid1
cat1.videos << vid2
cat1.videos << vid3