# Task: save in strings
class RepositoryPreseter
  attr_reader :repository

  def initialize(repository:)
    @repository = repository
  end

  def present_repo_info
    [repository.gem_name, repository.used_by, repository.watches, repository.stars,
     repository.forks, repository.contributors, repository.issues]
  end
end
