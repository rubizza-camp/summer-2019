require 'octokit'

class Client
  def self.initialize_client
    fetcher = new
    fetcher.client_login
    fetcher.client
  end

  attr_reader :client

  def initialize
    @client = nil
  end

  def client_login
    @client = Octokit::Client.new(access_token: fetch_token)
    @client.user.login
  rescue Octokit::Unauthorized
    puts 'Error. Entered invalid gem.'
    retry
  end

  private

  def fetch_token
    puts 'Enter your Github Personal Access Token:'
    gets.chomp
  end
end
