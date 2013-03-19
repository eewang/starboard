class Githubstar < Star

  def self.check_one_fork(user_name)
    repos = $github.repos.list user: user_name
    result = false
    repos.each do |repo|
      if repo['forks'] > 0
        result = true
      end
    end
    return result
  end

end