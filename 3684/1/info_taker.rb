require 'open-uri'
require 'nokogiri'

# :reek:TooManyStatements
# :reek:FeatureEnvy
# rubocop:disable Security/Open
# rubocop:disable Metrics/AbcSize
# rubocop:disable Metrics/MethodLength
class InfoTaker
  attr_reader :gem_name, :adress

  def initialize(gem_name, adress)
    @gem_name = gem_name
    @adress = adress
  end

  def info
    search(@gem_name, @adress)
  end

  private

  def search(gem_name, adress)
    document = Nokogiri::HTML(open(adress.to_s))

    documnet_for_used_by = Nokogiri::HTML(open("#{adress}/network/dependents"))

    info = []

    info << gem_name

    used_by = documnet_for_used_by.css("a[class='btn-link selected']")[0].text.split(' ').first
    info << used_by

    contributors = document.css("span[class='num text-emphasized']")[3].text.split(' ').first
    info << contributors

    issues = document.css("span[class='Counter']")[0].text.split(' ').first
    info << issues

    stars = document.css("a[class='social-count js-social-count']")[0].text.split(' ').first
    info << stars

    watch = document.css("a[class='social-count']")[0].text.split(' ').first
    info << watch

    forks = document.css("a[class='social-count']")[1].text.split(' ').first
    info << forks

    info
  end
end
# rubocop:enable Security/Open
# rubocop:enable Metrics/AbcSize
# rubocop:enable Metrics/MethodLength
