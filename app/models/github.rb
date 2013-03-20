class Github

  attr_accessor :events, :id, :issues, :url, :gists_url, :name, :company, :blog, :location, :email, :hireable, :bio, :repos, :followers, :following, :username

  def initialize(username)
    @username = username
    get_github
    get_repos
    get_events
  end

  def get_github
    response = Octokit.user(@username)
    @id =        response['id']
    @url =       response['html_url']
    @gists_url = response['gists_url']
    @name =      response['name']
    @company =   response['company']
    @blog =      response['blog']
    @location =  response['location']
    @email =     response['email']
    @hireable =  response['hireable']
    @bio =       response['bio']
    @followers = response['followers']
    @following = response['following']
  end

  def get_repos(language=nil)
    @repos = Octokit.repositories(@username)
  end

  def forked_repos
    @repos.select { |repo| repo.forks > 0 }
  end

  def get_repos_by_language(language)
    @repos.select { |repo| repo.get_repos_by_languageage.to_s.downcase == language.downcase }
  end

  def get_events
    @events = Octokit.user_events(@username)
  end

  def get_closed_pull_requests
    @events.select { |event| event.type == 'PullRequestEvent' && event.payload.action == 'closed'}
  end

end