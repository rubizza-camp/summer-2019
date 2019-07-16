require 'rubygems'
require 'mechanize'
require 'nokogiri'
require 'open-uri'
require_relative 'link'

class Statistics
  class << self
    def load_stats(gem_name)
      {
        used:         used(gem_name),
        watched:      watched(gem_name),
        stars:        stars(gem_name),
        forks:        forks(gem_name),
        contributors: contributors(gem_name),
        issues:       issues(gem_name)
      }
    end

    private

    def used(gem_name)
      repository = Link.new(gem_name)
      find_used(repository.link_to_repo)
    end

    def watched(gem_name)
      html_file(gem_name).css('.social-count')[0].text.strip
    end

    def stars(gem_name)
      html_file(gem_name).css('.social-count')[1].text.strip
    end

    def forks(gem_name)
      html_file(gem_name).css('.social-count')[2].text.strip
    end

    def contributors(gem_name)
      html_file(gem_name).css('.text-emphasized')[3].text.strip
    end

    def issues(gem_name)
      html_file(gem_name).css('.Counter')[0].text.strip
    end

    def html_file(gem_name)
      repository = Link.new(gem_name)
      main_doc(repository.link_to_repo)
    end

    def main_doc(link_to_repo)
      @main_doc = Nokogiri::HTML(URI.open(link_to_repo.to_s))
    end

    def doc_for_used_by(link_to_repo)
      @doc_for_used_by = Nokogiri::HTML(URI.open("#{link_to_repo}/network/dependents"))
    end

    def find_used(link_to_repo)
      used = ''
      doc_for_used_by(link_to_repo).css('.btn-link')[1].text.strip.each_line do |line|
        used = line.chomp
        break
      end
      used
    end
  end
end
