# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

first_names = %w(John Jack James Johnny Jerry Julian Julia Jorpo Jesse Jessie Jenny)
last_names = %w(Jones Jackson Janefield Jane Joo Jeans)

first_names.each { |f| last_names.each { |l| User.new(first_name: f, last_name: l, email: "#{f}@#{l}.com", password: 'password', password_confirmation: 'password').save! } }
