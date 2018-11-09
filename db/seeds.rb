# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'
require 'csv'

require 'activerecord-import'

puts 'Create funds'

t1 = Time.now

valid_funds = []
invalid_funds = []

filepath = 'db/DB_TEST.csv'
csv_options = { col_sep: ';', quote_char: '"', force_quotes: true,
                headers: :first_row, header_converters: :symbol }

CSV.foreach(filepath, csv_options) do |row|
  funds = Fund.new(isin: row[:isin],
                   secid: row[:secid],
                   performanceid: row[:performanceid],
                   fundid: row[:fundid],
                   securityname: row[:securityname],
                   company: row[:company])

  if funds.valid?
    valid_funds << funds
  else
    invalid_funds << funds
  end
end

valid_funds.each do |fund|
  fund.run_callbacks(:save) { false }
  fund.run_callbacks(:create) { false }
end

Fund.import valid_funds, validate: false

# Create reviews for funds -------------------------
Fund.all.each do |fund|
  rand(1..6).to_i.times do
    review = Review.new(
      structure: Faker::StarWars.quote,
      current: Faker::StarWars.wookiee_sentence,
      fund_id: fund.id
    )
    review.save
  end
end
# Timer ---------------------------------------------
t2 = Time.now
delta = t2 - t1

puts "Import effectué en : #{delta} secondes"
