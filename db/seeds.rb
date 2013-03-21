# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

users = [{ name: 'Jesse'},
        { name: 'Victoria'},
        { name: 'Bob'},
        { name: 'Tyler'},
        { name: 'Danny'},
        { name: 'Jane'},
        { name: 'Masha'},
        { name: 'Harrison'},
        { name: 'Eric'},
        { name: 'Sam'},
        { name: 'Person'},
        { name: 'Chuck'},
        { name: 'Sarah'},
        { name: 'John'},
        { name: 'Mark'},
        { name: 'Paul'},
        { name: 'Vinnie'},
        { name: 'Tina'},
        { name: 'Trixie'},
        { name: 'Daniel'},
        { name: 'Tim'},
        { name: 'Christina'},
        { name: 'Erin'},
        { name: 'Ei-lene'},
        ]

<<<<<<< HEAD
users.each do |user|
  u = User.find_or_create_by_name(user[:name])
  u.profile_pic = "http://lorempixel.com/210/210/people/"
  u.save
=======
User.all.each do |user|
  user.profile_pic = "http://lorempixel.com/210/210/people/"
  user.save
>>>>>>> seed
end
