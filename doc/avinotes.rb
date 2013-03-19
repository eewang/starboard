a = Achievement.new

a.user = User.find_by_name("avi")

avis_codeschool = CodeSchool.new('aviflombaum')

avis_codeschool.completed_courses #=> ["Ruby Bits"]

a.name = avis_codeschool.courses.first

AchivementWrapper::CodeSchool

CodeSchool.get_data

Github.get_data
