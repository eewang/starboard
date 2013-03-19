class Github

  attr_accessor :id, :url, :gists_url, :name, :company, :blog, :location, :email, :hireable, :bio, :public_repos, :followers, :following, :username

  def initialize(username)
    @username = username
    get_github
  end

  def get_github
    response = Octokit.user(@username)
    @id = response['id']
    @url = response['html_url']
    @gists_url = response['gists_url']
    @name = response['name']
    @company = response['company']
    @blog = response['blog']
    @location = response['location']
    @email = response['email']
    @hireable = response['hireable']
    @bio = response['bio']
    @public_repos = response['public_repos']
    @followers = response['followers']
    @following = response['following']
  end

end
