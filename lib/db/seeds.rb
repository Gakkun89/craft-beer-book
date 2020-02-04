require "faker"
require_relative "../models/beer"

50.times do
  Beer.create(
    name: Faker::Beer.name,
    brewery: Faker::Beer.brand,
    abv: rand(3..15),
    style: Faker::Beer.style,
    notes: Faker::Beer.malts,
    uscore: rand(1..5)
  )
end
