module GithubStars
  def check_forked(user_name)
    repos = $github.repos.list user: user_name
    repos.each do |repo|
      if repo['forks'] > 0
        true
      end
    end
    false
  end
end
