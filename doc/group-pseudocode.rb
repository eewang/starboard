# finish up teacher/student authorization 
  # edit/destroy links
  # star addition and subtration for getting stars and giving stars



# Groups:

# users has many groups, a group has many users

# teacher signs up first, checkbox that says if he is a teacher
  # change boolean in user model to true for is_teacher

# if checkbox is teacher, sign him in as a teacher. redirect to teacher view 
# where it shows the teacher's groups.

# form to create a new group
  # group name
  # student email addresses
  # group password

# sends email to students using action mailer with a link to sign up

# add group password to new signup field for a student 
  # match the group password in params with the group in the table 
  # create the associatioin in the user_groups join table


# invitation table to store invitations for a sender(user_id) with potential user emails
# also need user_groups join table to make association between user and groups 
