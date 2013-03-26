class User < ActiveRecord::Base
  before_save :check_blog,
              :get_external_data

  attr_accessible :name, :profile_pic, :stackoverflow_username, :treehouse_username, :codeschool_username, :github_username, :blog_url, :blog_count, :email, :password, :password_confirmation

  #@TODO - Build out validation rules
  validates_uniqueness_of :email

  has_secure_password

  has_many :achievements
  has_many :stars, :through => :achievements
  has_many :blogs

  def add_code_school_job
    
  end

  def check_blog
    unless self.blog_url.empty?
      self.blog_count = 0 if self.blog_count.nil?
      old_entries_count = self.blog_count
      current_entry_count = Blog.get_entries(self.blog_url).count
      new_posts = Array.new(current_entry_count - old_entries_count).collect do |i|
        "Create a Blog Post"
      end
      self.blog_count = current_entry_count
      self.check_achievements_by_array(new_posts, 'Blog')
    end
  end

  def get_external_data
    external_services = 
    { 
      Treehouse => self.treehouse_username,
      Codeschool => self.codeschool_username
      # Github => self.github_username
    }
    external_services.each do |service, identifier|
      if identifier 
        array = service.get_data(identifier)
        check_achievements_by_array(array, service.to_s)
      end
    end
  end

  def check_achievement_by_string(string, source_string)
    source_id = Source.where(:name => source_string).first.id
    star = Star.where(:name => string, :source_id => source_id).first_or_create
    # @TODO - has many collection ... star_ids
    starids = self.stars.collect { |a| a.id }

    # Necessary for updating blog posts.
    blog_star_id = Star.where(:name => "Create a Blog Post").first.id
    starids.delete(blog_star_id)

    unless starids.include? star.id
      self.achievements.build(:star_id => star.id)
    end
  end

  def check_achievements_by_array(array, source_string)
    array.each { |item| check_achievement_by_string(item, source_string) }
  end

  def get_profile_pic_from_email(email)
    hash = Digest::MD5.hexdigest(email.strip.downcase)
    "http://www.gravatar.com/avatar/" + hash + "?s=140"
  end

  def get_profile_pic
    self.profile_pic = get_profile_pic_from_email(self.email)
  end

  def refresh_bank
    @giftable_star_bank = 1000
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

end
