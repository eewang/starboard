sources = Source.first_or_create([
    {name: "Treehouse"},
    {name: "Codeschool"},
    {name: "Github"},
    {name: "Blog"}
])

users = User.first_or_create([
  { 
    name: 'Tyler',
    email: 'tyebud@gmail.com',
    blog_url: 'http://tmd.io/atom.xml',
    github_username: 'tylerdavis', 
    codeschool_username: 'tylermdavis', 
    treehouse_username: 'tylerdavis', 
    stackoverflow_username: 'tylerdavis',
    password: 'hella',
    password_confirmation: 'hella'
  },
  { 
    name: 'Danny Olinsky',
    email: 'danny.olinsky@flatironschool.com',
    blog_url: 'http://dolin.github.com/atom.xml',
    github_username: 'dolin',
    codeschool_username: 'dolinsky',
    treehouse_username: 'dannyolinsky',
    stackoverflow_username: 'danny-olinsky',
    password: 'hella',
    password_confirmation: 'hella'
  },
  {
    name: 'Jane Vora',
    email: 'jane.vora@flatironschool.com',
    blog_url: 'http://janeeats.github.com/atom.xml',
    github_username: 'janeeats',
    codeschool_username: 'janeeats',
    treehouse_username: 'janeeats',
    stackoverflow_username: 'janeeatsless',
    password: 'hella',
    password_confirmation: 'hella'
  },
  {
    name: 'Dan Gantz',
    email: 'dan.gantz@flatironschool.com',
    blog_url: 'http://firstgeneration.github.com/atom.xml',
    github_username: 'firstgeneration',
    codeschool_username: 'firstgeneration',
    treehouse_username: 'astonishingperson22',
    stackoverflow_username: 'firstgeneration',
    password: 'hella',
    password_confirmation: 'hella'
  },
  {
    name: 'Laura Brown',
    email: 'laura.brown@flatironschool.com',
    blog_url: 'http://1aurabrown.github.com/atom.xml',
    github_username: '1aurabrown',
    codeschool_username: '1aurabrown',
    treehouse_username: '1aurabrown',
    stackoverflow_username: '1aurabrown',
    password: 'hella',
    password_confirmation: 'hella'
  },
  {
    name: 'John Kelly Ferguson',
    email: 'john.ferguson@flatironschool.com',
    blog_url: 'http://johnkellyferguson.github.com/atom.xml',
    github_username: 'johnkellyferguson',
    codeschool_username: 'johnkellyferguson',
    treehouse_username: 'johnkferguson',
    stackoverflow_username: 'john-kelly-ferguson',
    password: 'hella',
    password_confirmation: 'hella'
  }
])

stars = Star.first_or_create([
  { name: 'Gifted Star'}
])