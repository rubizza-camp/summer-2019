# # THIS IS SIMPLE UNIT TEST, USING MYSELF FOR DEBUGGING
# require 'minitest/autorun'
# Dir[File.dirname(__FILE__) + './**/*.rb'].each { |file| require_relative file }

# class TestTopGems < MiniTest::Unit::TestCase
#   module TopGems
#     def setup
#       @gems_name = %w[sinatra rspec]
#       @gems_urls = { sinatra: 'https://github.com/sinatra/sinatra',
#                     rspec: 'http://github.com/rspec/rspec' }
#       @gems_stats = { sinatra: { name: :sinatra,
#                                 watched_by: 406,
#                                 stars: 10_620,
#                                 forks: 1907,
#                                 issues: 69,
#                                 contributors: 361,
#                                 used_by: 144_655 },
#                       rspec: { name: :rspec,
#                               watched_by: 96,
#                               stars: 2536,
#                               forks: 204,
#                               issues: 1,
#                               contributors: 21,
#                               used_by: 317_294 } }
#       @gems_stats_with_coefficient = { sinatra: { name: :sinatra,
#                                                   watched_by: 406,
#                                                   stars: 10_620,
#                                                   forks: 1907,
#                                                   issues: 69,
#                                                   contributors: 361,
#                                                   used_by: 144_655,
#                                                   rate: 15_558 },
#                                       rspec: { name: :rspec,
#                                                 watched_by: 96,
#                                                 stars: 2536,
#                                                 forks: 204,
#                                                 issues: 1,
#                                                 contributors: 21,
#                                                 used_by: 317_294,
#                                                 rate: 5_260 } }
#       @options_with_path = { path: './gems_for_test.yml' }
#       @options_with_path_and_name = { name: 'sin', path: './gems_for_test.yml' }
#       @options_with_wrong_path = { path: './some/dfs.yml' }
#     end

#     def test_parsing_yaml_file
#       assert_equal Array, FileWithYamlParser.read(@options_with_path).class
#       assert_equal %w[sinatra rspec], FileWithYamlParser.read(@options_with_path)
#     end

#     def test_parsing_yaml_file_with_options_by_name
#       assert_equal Array, FileWithYamlParser.read(@options_with_path_and_name).class
#       assert_equal %w[sinatra], FileWithYamlParser.read(@options_with_path_and_name)
#     end

#     def test_getting_url
#       assert_equal Hash, GemsHomePageUrl.get_url(@gems_name).class
#       assert_equal @gems_urls, GemsHomePageUrl.get_url(@gems_name)
#     end

#     def test_getting_stats
#       # skip 'this test take some time for query'
#       assert_equal Hash, HtmlParser.call(@gems_urls).class
#       assert HtmlParser.call(@gems_urls)
#     end

#     def test_set_ratings
#       assert_equal Hash, RateCount.call(@gems_stats).class
#       assert_equal @gems_stats_with_coefficient, RateCount.call(@gems_stats)
#     end
#   end
# end
