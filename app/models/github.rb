class Github

  attr_accessor :events, :id, :issues, :url, :gists_url, :name, :company, :blog, :location, :email, :hireable, :bio, :repos, :followers, :following, :username

# create empty array to store github achievements, accessible to all methods
# create individual methods for each achievement we want to track
# push achievement into array 

  def self.get_data(username)
    result = []
    
    repos = self.get_repos(username)
    result.concat(self.get_forked_repos_achievements(repos))
    
    events = self.get_events(username)
    result.concat(self.get_open_source_commits_achievements(events))
    
  end

  def self.get_open_source_commits_achievements(events)
    num_open_commits = self.count_open_source_commits(events)
    commit_achievements = []
      if num_open_commits >= 10
        commit_achievements << ['Github - Make a commit to 10 opensource projects',
                               'Github - Make a commit to 5 opensource projects',
                               'Github - Make a commit to an opensource project']
      elsif (num_open_commits >=5) && (num_open_commits < 10)
        commit_achievements << ['Github - Make a commit to 5 opensource projects',
                                'Github - Make a commit to an opensource project']
      elsif (num_open_commits > 0) && (num_open_commits < 5)
        commit_achievements << 'Github - Make a commit to an opensource project'
      else
        commit_achievements << 'You have not made any open source commits, get on it!'
      end
  end

  def self.get_forked_repos_achievements(repos)
    num_repos = self.count_forked_repos(repos)
    forked_achievements = []
      if num_repos >= 10
        forked_achievements << ['Github - Have 10 opensource projects forked',
                               'Github - Have 5 opensource projects forked',
                               'Github - Have an opensource project forked']
      elsif (num_repos >=5) && (num_repos < 10)
        forked_achievements << ['Github - Have 5 opensource projects forked',
                                'Github - Have an opensource project forked']
      elsif (num_repos > 0) && (num_repos < 5)
        forked_achievements << 'Github - Have an opensource project forked'
      end
  end

  def self.get_github(username)
    response = $octokit.user(username)
    {
      :id =>        response['id'],
      :url =>       response['html_url'],
      :gists_url => response['gists_url'],
      :name =>      response['name'],
      :company =>   response['company'],
      :blog =>      response['blog'],
      :location =>  response['location'],
      :email =>    response['email'],
      :hireable => response['hireable'],
      :bio =>       response['bio'],
      :followers => response['followers'],
      :following => response['following']
    }
  end

  def self.get_repos(username)
    $octokit.repositories(username)
  end

  def self.forked_repos(repos)
    repos.select { |repo| repo.forks > 0 }
  end

  def self.count_forked_repos(repos)
    self.forked_repos(repos).count
  end

  def self.get_repos_by_language(language, repos)
    repos.select { |repo| repo.get_repos_by_language.to_s.downcase == language.downcase }
  end

  def self.get_events(username)
    $octokit.user_events(username)
  end

  def self.get_open_source_commits(events)
    events.select { |event| event.type == 'PullRequestEvent' && event.payload.action == 'closed'}
  end

  def self.count_open_source_commits(events)
    self.get_open_source_commits(events).count
  end

end