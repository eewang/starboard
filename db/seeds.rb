sources = Source.first_or_create([
    {name: "Treehouse"},
    {name: "Codeschool"},
    {name: "Github"},
    {name: "Blog"},
    {name: "Teacher"},
    {name: "Handraise"},
    {name: "Student"}
])

# s = Source.where(:name => 'Student').first

star = Star.first_or_create([
  { name: 'Gifted Star' }
])

# users = User.first_or_create([
#   { 
#     name: 'Tyler',
#     email: 'tyebud@gmail.com',
#     blog_url: 'http://tmd.io/atom.xml',
#     github_username: 'tylerdavis', 
#     codeschool_username: 'tylermdavis', 
#     treehouse_username: 'tylerdavis', 
#     password: 'hella',
#     password_confirmation: 'hella'
#   },
#   { 
#     name: 'Danny Olinsky',
#     email: 'dannyolinsky@gmail.com',
#     blog_url: 'http://dolin.github.com/atom.xml',
#     github_username: 'dolin',
#     codeschool_username: 'dolinsky',
#     treehouse_username: 'dannyolinsky',
#     password: 'hella',
#     password_confirmation: 'hella'
#   },
#   {
#     name: 'Jane Vora',
#     email: 'jane.vora@flatironschool.com',
#     blog_url: 'http://janeeats.github.com/atom.xml',
#     github_username: 'janeeats',
#     codeschool_username: 'janeeats',
#     treehouse_username: 'janeeats',
#     password: 'hella',
#     password_confirmation: 'hella'
#   },
#   {
#     name: 'Dan Gantz',
#     email: 'dan.gantz@flatironschool.com',
#     blog_url: 'http://firstgeneration.github.com/atom.xml',
#     github_username: 'firstgeneration',
#     codeschool_username: 'firstgeneration',
#     treehouse_username: 'astonishingperson22',
#     password: 'hella',
#     password_confirmation: 'hella'
#   },
#   {
#     name: 'Laura Brown',
#     email: 'laura.brown@flatironschool.com',
#     blog_url: 'http://1aurabrown.github.com/atom.xml',
#     github_username: '1aurabrown',
#     codeschool_username: '1aurabrown',
#     treehouse_username: '1aurabrown',
#     password: 'hella',
#     password_confirmation: 'hella'
#   },
#   {
#     name: 'John Kelly Ferguson',
#     email: 'john.ferguson@flatironschool.com',
#     blog_url: 'http://johnkellyferguson.github.com/atom.xml',
#     github_username: 'johnkellyferguson',
#     codeschool_username: 'johnkellyferguson',
#     treehouse_username: 'johnkferguson',
#     password: 'hella',
#     password_confirmation: 'hella'
#   }, 
#   {
#     name: 'Jane Vora',
#     email: 'jane.vora@flatironschool.com',
#     blog_url: 'http://janeeats.github.com/atom.xml',
#     github_username: 'janeeats',
#     codeschool_username: 'janeeats',
#     treehouse_username: 'janeeats',
#     password: 'hella',
#     password_confirmation: 'hella'
#   },
#   {
#     name: 'Eric Iacutone',
#     email: 'eric.iacutone@flatironschool.com',
#     blog_url: 'http://iacutone.github.com/atom.xml',
#     github_username: 'iacutone',
#     codeschool_username: 'iactuone',
#     treehouse_username: 'iactuone',
#     password: 'hella',
#     password_confirmation: 'hella'
#   },
#   {
#     name: 'Jesse Larusso',
#     email: 'jesselarusso@gmail.com',
#     blog_url: 'http://jlarusso.github.com/atom.xml',
#     github_username: 'jlarusso',
#     codeschool_username: 'jlarusso',
#     treehouse_username: 'jesselarusso',
#     password: 'hella',
#     password_confirmation: 'hella'
#   },
#   {
#     name: 'Ei-lene Heng',
#     email: 'eilene.heng@flatironschool.com',
#     blog_url: 'http://ei-lene.github.com/atom.xml',
#     github_username: 'ei-lene',
#     codeschool_username: 'eilene',
#     treehouse_username: 'eilene',
#     password: 'hella',
#     password_confirmation: 'hella'
#   },
#   {
#     name: 'Christina Chang',
#     email: 'christina.chang@flatironschool.com',
#     blog_url: 'http://christinachang.github.com/atom.xml',
#     github_username: 'christinachang',
#     codeschool_username: 'christinachang',
#     treehouse_username: 'christinachang',
#     password: 'hella',
#     password_confirmation: 'hella'
#   },
#   {
#     name: 'Rahul Seshan',
#     email: 'rahul.seshan@flatironschool.com',
#     blog_url: 'http://rseshan.github.com/atom.xml',
#     github_username: 'rseshan',
#     codeschool_username: 'rseshan',
#     treehouse_username: 'rseshan',
#     password: 'hella',
#     password_confirmation: 'hella'
#   },
#   {
#     name: 'Cho Kim',
#     email: 'cho.kim@flatironschool.com',
#     blog_url: 'http://chokim.github.com/atom.xml',
#     github_username: 'ChoKim',
#     codeschool_username: 'ChoKim',
#     treehouse_username: 'chokim',
#     password: 'hella',
#     password_confirmation: 'hella'
#   },
#   {
#     name: 'Andrew Callahan',
#     email: 'andrew.callahan@flatironschool.com',
#     blog_url: 'http://andrewcallahan.tumblr.com/rss',
#     github_username: 'andrewcallahan',
#     codeschool_username: 'andrewcallahan',
#     treehouse_username: 'andrewcallahan',
#     password: 'hella',
#     password_confirmation: 'hella'
#   }
# ])

# group1 = Group.create({name: 'Flatiron 001', password: 'hella', creator_id: 1})
# group2 = Group.create({name: 'Flatiron 002', password: 'hella', creator_id: 1})

# # Populate profile pic attribute from email address attribute
# User.all.each do |user|
#   user.get_profile_pic
#   user.giftable_star_bank = 5
#   user.groups << group1
#   user.groups << group2
#   user.save
# end







