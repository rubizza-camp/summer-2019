require_relative '../lib/gem_sorter.rb'
require_relative '../lib/repo_body.rb'
require_relative '../lib/gem_entity.rb'
require_relative './fake_internet.rb'
require 'minitest/autorun'

class GemSorterSpec < Minitest::Test
  def setup
    gems = %w[rails].map do |name|
      repo = RepoBody.new(name, FakeInternet.new)
      repo.fetch_params

      gem_entity = GemEntity.new(repo.name, repo.doc, repo.used_by_doc, false)
      gem_entity.set_params
      gem_entity
    end
    @gem_sorter = GemSorter.new.call(gems)
  end

  def test_call
    assert_equal 67964, @gem_sorter.dig(0, 0)
  end
end
