# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

users = User.first_or_create([
        { name: 'Jesse' },
        { name: 'Victoria' },
        { name: 'Bob' },
        { name: 'Tyler' },
        { name: 'Danny' },
        { name: 'Jane' },
        { name: 'Masha' },
        { name: 'Harrison' },
        { name: 'Eric' },
        { name: 'Sam' },
        { name: 'Person' },
        { name: 'Chuck' },
        { name: 'Sarah' },
        { name: 'John' },
        { name: 'Mark' },
        { name: 'Paul' },
        { name: 'Vinnie' },
        { name: 'Tina' },
        { name: 'Trixie' },
        { name: 'Daniel' },
        { name: 'Tim' },
        { name: 'Christina' },
        { name: 'Erin' },
        { name: 'Ei-lene' }
        ])

User.all.each do |user|
  user.profile_pic = "http://lorempixel.com/210/210/people/"
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
    { name: 'Github - Teacher Star' },
    { name: 'Github - Student Star'}
])

requirements = Requirement.first_or_create([
    { description: "Write 1 blog post", :star_id => 1 },
    { description: "Write 1 blog post", :star_id => 2 }
])














