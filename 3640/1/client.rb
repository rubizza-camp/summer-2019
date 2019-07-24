require 'octokit'

class Client
  def self.initialize_client
    fetcher = new
    fetcher.client
  end

  def client
    begin
      client = Octokit::Client.new(access_token: fetch_token)
      client.user.login
    rescue Octokit::Unauthorized
      puts 'Error. Entered invalid gem.'
      retry
    end
    client
  end

  private

  def fetch_token
    puts 'Enter your Github Personal Access Token:'
    gets.chomp
  end
end
