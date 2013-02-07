# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Tool.destroy_all
User.destroy_all

Tool.create!(name: "EntityFramework")
Tool.create!(name: "Linq to SQL")
Tool.create!(name: "Jenkins")
Tool.create!(name: "Cucumber")
Tool.create!(name: "RSpec")
Tool.create!(name: "Capybara")
Tool.create!(name: "Puppet")
Tool.create!(name: "Chef")
Tool.create!(name: "Go")
Tool.create!(name: "Redis")
Tool.create!(name: "NuGet")
Tool.create!(name: "Backbone.js")
Tool.create!(name: "NHibernate")
Tool.create!(name: "XUnit")
Tool.create!(name: "NUnit")
Tool.create!(name: "JUnit")
Tool.create!(name: "SpecFlow")
Tool.create!(name: "MSTest")
Tool.create!(name: "MSBuild")
Tool.create!(name: "Rake")
Tool.create!(name: "Make")
Tool.create!(name: "FactoryGirl")
Tool.create!(name: "Moq")
Tool.create!(name: "RhinoMocks")
Tool.create!(name: "Dapper.NET")
Tool.create!(name: "PetaPoco")
Tool.create!(name: "Angular.js")
Tool.create!(name: "Amber.js")
Tool.create!(name: "Knockout.js")
Tool.create!(name: "SignalR")
Tool.create!(name: "NServiceBus")

User.create!(username: "Good_Guy", first_name: "Good", email: 'random_email@email.com', last_name:"Guy", password: 'test_pass', password_confirmation: 'test_pass')
User.create!(username: "test_user", first_name: "Good", email: 'another_random_email@email.com', last_name:"Guy", password: 'test_pass', password_confirmation: 'test_pass')
