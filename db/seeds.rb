# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Tool.destroy_all
User.destroy_all
Tool.create!(name: "NHibernate")
Tool.create!(name: "--NHibernate1")
Tool.create!(name: "-/NHibernate2")

User.create!(username: "Good_Guy", first_name: "Good", email: 'random_email@email.com', last_name:"Guy", password: 'test_pass', password_confirmation: 'test_pass')
User.create!(username: "test_user", first_name: "Good", email: 'another_random_email@email.com', last_name:"Guy", password: 'test_pass', password_confirmation: 'test_pass')
