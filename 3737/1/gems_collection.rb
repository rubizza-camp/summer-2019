require_relative 'gem_info.rb'
require 'yaml'

# class that collect all gems with their info
class GemsCollection
  def initialize
    @gems = {}
  end

  def gems_list(option)
    file = YAML.load_file(option[:file])
    hash_of_gems(file['gems'])
    gem_list_to_show(option)
  end

  private

  def hash_of_gems(file)
    file.each do |lib|
      stat = GemInfo.new(lib).gem_stat
      next unless stat
      @gems[lib] = stat
    end
    @gems
  end

  def gem_list_to_show(option)
    gems_with_similar_name(option)
    top_of_gems(option)
  end

  def gems_with_similar_name(option)
    gem_name = option[:name]
    return unless gem_name
    @gems.select! { |name, _| name.include?(gem_name) }
  end

  def order_gems_by_rating
    @gems.sort_by { |_, stat| -stat[:rating] }
  end

  def top_of_gems(option)
    return order_gems_by_rating.take(option[:top].to_i).to_h if option[:top].to_i.positive?
    order_gems_by_rating.to_h
  end
end
