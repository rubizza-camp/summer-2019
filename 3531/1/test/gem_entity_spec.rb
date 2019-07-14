require_relative '../lib/repo_body.rb'
require_relative '../lib/gem_entity.rb'
require_relative './fake_internet.rb'
require 'minitest/autorun'

class GemEntitySpec < Minitest::Test
  def setup
    repo = RepoBody.new('rails', FakeInternet.new)
    repo.fetch_params
    @gem = GemEntity.new(repo.name, repo.doc, repo.used_by_doc, false)
    @gem.set_params
    @stats = @gem.stats
    @score = @gem.score
  end

  def test_gem_entity_name
    assert_equal 'rails', @gem.name
  end

  def test_issues
    assert_equal '369', @stats[:issues]
  end

  def test_stars
    assert_equal '43,612', @stats[:stars]
  end

  def test_forks
    assert_equal '17,538', @stats[:forks]
  end

  def test_watched_by
    assert_equal '2,608', @stats[:watched_by]
  end

  def test_contributors
    assert_equal '3,837', @stats[:contributors]
  end

  def test_set_score
    assert_equal 67_964, @score
  end
end
