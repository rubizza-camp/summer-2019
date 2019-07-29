# frozen_string_literal: true

# Get list of gem entities
class ListingGems
  attr_reader :name, :file

  def initialize(params)
    @name = params[:name]
    @file = params[:file]
  end

  def load
    gems = YAML.load_file(file)['gems']
    gems.select! { |gem| gem.include?(name) } if name
    gems.map { |gem_name| GemEntity.new(gem_name) }
  end
end
