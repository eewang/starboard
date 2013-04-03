class User < ActiveRecord::Base
  include HTTParty

  attr_accessible :name, :profile_pic, :stackoverflow_username, :treehouse_username, :codeschool_username, :github_username, :blog_url, :blog_count, :email, :password, :password_confirmation, :is_teacher

  validates_uniqueness_of :email

  has_secure_password

  has_many :achievements
  has_many :stars, :through => :achievements
  has_many :blogs
  has_many :group_users
  has_many :groups, :through => :group_users 
  has_many :invitations, :dependent => :destroy

  def get_external_data
    external_services = 
    {
      Treehouse => self.treehouse_username,
      Codeschool => self.codeschool_username,
      Github => self.github_username,
      Blog => self
    }
    external_services.each do |service, identifier|
      if identifier
        begin
          service_object = service.new
          array = service_object.get_data(identifier)
          check_achievements_by_array(array, service.to_s)
        rescue => e
          p "There was an error pulling from #{service} for #{identifier} - #{e}"
        end
      end
    end
  end
 
 def check_achievement_by_string(string, source_string)
   source_id = Source.where(:name => source_string).first.id
   star = Star.where(:name => string, :source_id => source_id).first_or_create
  # @TODO - has many collection ... star_ids
    starids = self.stars.collect { |a| a.id }

    # Necessary for updating blog posts.
    blog_star_id = Star.where(:name => "Write a Blog Post").first.id
    starids.delete(blog_star_id)

    # move me out to get_external_data
    unless starids.include? star.id
       self.achievements.build(:star_id => star.id)
     end
   end

  # def check_achievement_by_string(string, source_string)
  #   source_id = Source.where(:name => source_string).first.id
  #   star = Star.where(:name => string, :source_id => source_id).first_or_create
  #   if !self.star_ids.include?(star.id) || star.name = "Write a Blog Post"
  #     self.achievements.build(:star_id => star.id)
  #   end
  # end

  def check_achievements_by_array(array, source_string)
    if array #at this point, i want to check what's in the array, if blog post do 1 thing, else do typical path
      array.each { |item| check_achievement_by_string(item, source_string) }
    end
  end

  def get_profile_pic_from_email(email)
    hash = Digest::MD5.hexdigest(email.strip.downcase)
    if check_if_gravatar_exists(hash)
      "http://www.gravatar.com/avatar/" + hash + "?s=440"
    else
      "/assets/defaults/zoo#{rand(9) + 1}.jpg"
    end
  end

  def check_if_gravatar_exists(hash)
    url = "http://www.gravatar.com/avatar/#{hash}?d=404"
    response = self.class.get(url)
    case response.code
    when 200
      true
    else
      false
    end
  end

  def get_profile_pic
    self.update_attribute(:profile_pic, get_profile_pic_from_email(self.email))
  end

  def award_giftable_stars(int)
    self.giftable_star_bank = int
  end

  def can_give_star?
    self.giftable_star_bank > 0
  end

  def give_achievement_to(receiver, message)
    # self.giftable_star_bank -= # REPLACE WITH ACTIVE RECORD COUNTERS
    star = Star.where(:name => "Gifted Star").first
    receiver.achievements.create({ :star_id => star.id, 
                                   :message => message,
                                   :sender_id => self.id })
  end

  def course_stars
    self.stars.select { |star| star.source.name == 'Treehouse' || star.source.name == 'Codeschool' }.count
  end  

  def codeschool_stars
    self.stars.select { |star| star.source.name == 'Codeschool' }.count
  end  

  def treehouse_stars
    self.stars.select { |star| star.source.name == 'Treehouse' }.count
  end

  def blog_stars
    self.stars.select { |star| star.source.name == 'Blog' }.count
  end

  def github_stars
    self.stars.select { |star| star.source.name == 'Github' }.count
  end

  def find_group(params)
    Group.where(:name => params[:group_name], :password => params[:group_password]).first
  end

  def as_json(option={})
    {
      :id             => self.id,
      :name           => self.name,
      :achievements   => self.achievements,
      :profile_pic    => self.profile_pic
    }
  end

end
