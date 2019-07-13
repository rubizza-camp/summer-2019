require 'httparty'

response =
  HTTParty.get("https://api.github.com/repos/sinatra/sinatra")
puts response["watchers_count"]
puts response["subscribers_count"]
puts response["network_count"]
auth = {:username => "gannagoodkevich@gmail.com", :password => "Pusivill1999"}
@bla = HTTParty.get("https://api.github.com/repos/sinatra/sinatra", 
                     :basic_auth => auth)
puts @bla["open_issues"]#issues
puts @bla["watchers"]
puts @bla["forks"]

@bla1 = HTTParty.get("https://rubygems.org/api/v1/gems/rails.json")
puts @bla1["source_code_uri"]
