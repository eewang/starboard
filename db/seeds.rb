# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
begin
  users = User.first_or_create([ { name: 'Jesse'},
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
                        ])
rescue => ex
  puts "ERROR #{ex}"
end

User.all.each do |user|
  unless user.email.nil?
    user.get_profile_pic
  else
    user.profile_pic = "http://lorempixel.com/140/140/people/1"
  end
  user.save
end


stars = Star.first_or_create([
    { name: 'Blog Post' },
    { name: 'CodeSchool - Try Ruby' },
    { name: 'CodeSchool - Ruby Bits' },
    { name: 'CodeSchool - Ruby Bits 2' },
    { name: 'CodeSchool - Rails Best Practices' },
    { name: 'CodeSchool - Rails for Zombies' },
    { name: 'CodeSchool - Rails for Zombies 2' },
    { name: 'CodeSchool - Rails Testing for Zombies' },
    { name: 'CodeSchool - Testing with RSpec' },
    { name: 'CodeSchool - Try Git' },
    { name: 'CodeSchool - Git Real' },
    { name: 'CodeSchool - Try jQuery' },
    { name: 'CodeSchool - jQuery Air - Captains Log' },
    { name: 'CodeSchool - CSS Cross Country' },
    { name: 'CodeSchool - Functional HTML5 and CSS3' },
    { name: 'CodeSchool - Journey into Mobile' },
    { name: 'Github - Have an opensource project forked' },
    { name: 'Github - Have 5 opensource projects forked' },
    { name: 'Github - Have 10 opensource projects forked' },
    { name: 'Github - Make a commit to an opensource project' },
    { name: 'Github - Make a commit to 5 opensource projects' },
    { name: 'Github - Make a commit to 10 opensource projects' },
    { name: 'Github - Opensource a Ruby project' },
    { name: 'Github - Opensource 5 Ruby projects' },
    { name: 'Github - Opensource 10 Ruby projects' },
    { name: 'Teacher Star' },
    { name: 'Student Star'}
])

requirements = Requirement.first_or_create([
    { description: "Complete 1 blog post", star_id: 1 },
    { description: "Complete try ruby", star_id: 2 },
    { description: "Complete try ruby", star_id: 3 },
    { description: "Complete Ruby Bits", star_id: 4 },
    { description: "Complete Ruby Bits 2", star_id: 5 },
    { description: "Complete Rails Best Practices", star_id: 6 },
    { description: "Complete Rails for Zombies", star_id: 7 },
    { description: "Complete Rails for Zombies 2", star_id: 8 },
    { description: "Complete Rails Testing for Zombies", star_id: 9 },
    { description: "Complete Testing with RSpec", star_id: 10 },
    { description: "Complete Try Git", star_id: 11 },
    { description: "Complete Git Real", star_id: 12 },
    { description: "Complete Try jQuery", star_id: 13 },
    { description: "Complete jQuery Air - Captains Log", star_id: 13 },
    { description: "Complete CSS Cross Country", star_id: 14 },
    { description: "Complete Functional HTML5 and CSS3", star_id: 15 },
    { description: "Complete Journey into Mobile", star_id: 16 },
    { description: "Opensource Project Forked", star_id: 17 },
    { description: "Opensource Project Forked #1", star_id: 18 },
    { description: "Opensource Project Forked #2", star_id: 18 },
    { description: "Opensource Project Forked #3", star_id: 18 },
    { description: "Opensource Project Forked #4", star_id: 18 },
    { description: "Opensource Project Forked #5", star_id: 18 },
    { description: "Opensource Project Forked #1", star_id: 19 },
    { description: "Opensource Project Forked #2", star_id: 19 },
    { description: "Opensource Project Forked #3", star_id: 19 },
    { description: "Opensource Project Forked #4", star_id: 19 },
    { description: "Opensource Project Forked #5", star_id: 19 },
    { description: "Opensource Project Forked #6", star_id: 19 },
    { description: "Opensource Project Forked #7", star_id: 19 },
    { description: "Opensource Project Forked #8", star_id: 19 },
    { description: "Opensource Project Forked #9", star_id: 19 },
    { description: "Opensource Project Forked #10", star_id: 19 },    
    { description: "Commit to an Opensource Project", star_id: 20 },
    { description: "Commit to an Opensource Project #1", star_id: 21 },
    { description: "Commit to an Opensource Project #2", star_id: 21 },
    { description: "Commit to an Opensource Project #3", star_id: 21 },
    { description: "Commit to an Opensource Project #4", star_id: 21 },
    { description: "Commit to an Opensource Project #5", star_id: 21 },
    { description: "Commit to an Opensource Project #1", star_id: 22 },
    { description: "Commit to an Opensource Project #2", star_id: 22 },
    { description: "Commit to an Opensource Project #3", star_id: 22 },
    { description: "Commit to an Opensource Project #4", star_id: 22 },
    { description: "Commit to an Opensource Project #5", star_id: 22 },
    { description: "Commit to an Opensource Project #6", star_id: 22 },
    { description: "Commit to an Opensource Project #7", star_id: 22 },
    { description: "Commit to an Opensource Project #8", star_id: 22 },
    { description: "Commit to an Opensource Project #9", star_id: 22 },
    { description: "Commit to an Opensource Project #10", star_id: 22 },
    { description: "Opensource a Ruby Project", star_id: 23 },
    { description: "Opensource a Ruby Project #1", star_id: 24 },
    { description: "Opensource a Ruby Project #2", star_id: 24 },
    { description: "Opensource a Ruby Project #3", star_id: 24 },
    { description: "Opensource a Ruby Project #4", star_id: 24 },
    { description: "Opensource a Ruby Project #5", star_id: 24 },
    { description: "Opensource a Ruby Project #1", star_id: 25 },
    { description: "Opensource a Ruby Project #2", star_id: 25 },
    { description: "Opensource a Ruby Project #3", star_id: 25 },
    { description: "Opensource a Ruby Project #4", star_id: 25 },
    { description: "Opensource a Ruby Project #5", star_id: 25 },
    { description: "Opensource a Ruby Project #6", star_id: 25 },
    { description: "Opensource a Ruby Project #7", star_id: 25 },
    { description: "Opensource a Ruby Project #8", star_id: 25 },
    { description: "Opensource a Ruby Project #9", star_id: 25 },
    { description: "Opensource a Ruby Project #10", star_id: 25 },
    { description: "Teacher Star", star_id: 26 },
    { description: "Student Star", star_id: 27 }
])

achievements = Achievement.first_or_create([
    { user_id: 1, star_id: 1 },
    { user_id: 1, star_id: 2 },
    { user_id: 1, star_id: 3 },
    { user_id: 1, star_id: 4 },
    { user_id: 2, star_id: 5 },
    { user_id: 2, star_id: 6 },
    { user_id: 2, star_id: 7 },
    { user_id: 2, star_id: 8 },
    { user_id: 3, star_id: 1 },
    { user_id: 3, star_id: 2 },
    { user_id: 3, star_id: 3 },
    { user_id: 3, star_id: 4 },
    { user_id: 4, star_id: 5 },
    { user_id: 4, star_id: 6 },
    { user_id: 4, star_id: 7 },
    { user_id: 4, star_id: 8 }
])

