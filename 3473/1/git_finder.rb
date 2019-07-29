# frozen_string_literal: true

require 'nokogiri'
require 'open-uri'

class GitFinder
  WAIT_SERVER = 3
  NUM_OF_ATTEMPTS = 5

  def git
    link.split('/').take(5).join('/').chomp('#readme').chomp('.git') if link
  rescue OpenURI::HTTPError => err
    raise err unless err.message.include? '404'
  end

  def initialize(gem_name)
    @name = gem_name
    @attempt = 1
  end

  private

  def doc
    @doc ||= Nokogiri::HTML(URI.open("https://rubygems.org/gems/#{@name}"))
  rescue OpenURI::HTTPError => err
    server_err_rescue err
    retry
  end

  def server_err_rescue(err)
    raise err unless err.message.include?('5') && @attempt <= NUM_OF_ATTEMPTS

    @attempt += 1
    sleep WAIT_SERVER
  end

  def link
    doc.css('a#home', 'a#code').map { |tag| tag.attribute('href').to_s }.select do |link|
      link.include?('github')
    end.first
  end
end
