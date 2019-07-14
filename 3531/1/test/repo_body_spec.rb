require_relative '../lib/repo_body.rb'
require_relative './fake_internet.rb'
require 'minitest/autorun'

class RepoBodySpec < Minitest::Test
  def setup
    @repo = RepoBody.new('rails', FakeInternet.new)
    @repo.fetch_params
  end

  def test_set_git_url
    assert_equal 'http://github.com/rails/rails', @repo.git_url
  end

  def test_fetch_doc
    assert_equal '369', @repo.doc.css('span.Counter')[0].text
  end
end
