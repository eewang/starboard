class Github

  attr_accessor :events, :id, :issues, :url, :gists_url, :name, :company, :blog, :location, :email, :hireable, :bio, :repos, :followers, :following, :username

# create empty array to store github achievements, accessible to all methods
# create individual methods for each achievement we want to track
# push achievement into array 

  def get_data(username)
    result = []
    
    repos = self.get_repos(username)
    result.concat(self.get_forked_repos_achievements(repos))
    
    events = self.get_events(username)
    result.concat(self.get_open_source_commits_achievements(events))

    language = 'Ruby'
    result.concat(self.get_ruby_projects(language, repos))

    result.flatten
    
  end

  def get_ruby_projects(language, repos)
    num_ruby_projects = (self.get_repos_by_language(language, repos)).count
    ruby_achievements = []
      if num_ruby_projects >= 10
        ruby_achievements << ['Opensource 10 Ruby projects',
                               'Opensource 5 Ruby projects',
                               'Opensource a Ruby project']
      elsif (num_ruby_projects >=5) && (num_ruby_projects < 10)
        ruby_achievements << ['Opensource 5 Ruby projects',
                                'Opensource a Ruby project']
      elsif (num_ruby_projects > 0) && (num_ruby_projects < 5)
        ruby_achievements << 'Opensource a Ruby project'
      else
        ruby_achievements << []
      end
  end

  def get_open_source_commits_achievements(events)
    num_open_commits = self.count_open_source_commits(events)
    commit_achievements = []
      if num_open_commits >= 10
        commit_achievements << ['Make a commit to 10 opensource projects',
                               'Make a commit to 5 opensource projects',
                               'Make a commit to an opensource project']
      elsif (num_open_commits >=5) && (num_open_commits < 10)
        commit_achievements << ['Make a commit to 5 opensource projects',
                                'Make a commit to an opensource project']
      elsif (num_open_commits > 0) && (num_open_commits < 5)
        commit_achievements << 'Make a commit to an opensource project'
      else
        commit_achievements << []
      end
  end

  def get_forked_repos_achievements(repos)
    num_repos = self.count_forked_repos(repos)
    forked_achievements = []
      if num_repos >= 10
        forked_achievements << ['Have 10 opensource projects forked',
                               'Have 5 opensource projects forked',
                               'Have an opensource project forked']
      elsif (num_repos >=5) && (num_repos < 10)
        forked_achievements << ['Have 5 opensource projects forked',
                                'Have an opensource project forked']
      elsif (num_repos > 0) && (num_repos < 5)
        forked_achievements << 'Have an opensource project forked'
      else
        forked_achievements << []
      end
  end

  def get_github(username)
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

  def get_repos(username)
    $octokit.repositories(username)
  end

  def forked_repos(repos)
    repos.select { |repo| repo.forks > 0 }

  end

  def count_forked_repos(repos)
    self.forked_repos(repos).count
  end

  def get_repos_by_language(language, repos)
    repos.select { |repo| repo.language == language }
  end

  def get_events(username)
    $octokit.user_events(username)
  end

  def get_open_source_commits(events)
    events.select { |event| event.type == 'PullRequestEvent' && event.payload.action == 'closed'}
  end

  def count_open_source_commits(events)
    self.get_open_source_commits(events).count
  end

end