module AchievementsHelper

   def self.student_message(user)
    student_star = Star.where(:name => 'Gifted Star').first.id
    @user.achievements.where("message IS NOT NULL AND star_id = #{student_star}")
  end


end
