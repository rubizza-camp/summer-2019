# frozen_string_literal: true

require './scraper'
require 'terminal-table'
class TableDrawer
  PATH_TO_WEIGHTS = 'weights.yaml'
  KEYS = %i[name watches stars forks contributors issues used_by].freeze

  def initialize(hash, top)
    @info_hash = hash
    @top = top
  end

  def draw
    puts Terminal::Table.new headings: [I18n.t('name'), I18n.t('watches'), I18n.t('stars'),
                                        I18n.t('forks'), I18n.t('contributors'),
                                        I18n.t('issues'), I18n.t('used_by')], rows: rows
  end

  private

  attr_reader :info_hash, :top

  def weights
    @weights ||= YAML.load_file(PATH_TO_WEIGHTS)['weights']
                     .transform_keys(&:to_sym)
  end

  def rows
    table_rows = append_names_transform.values.sort_by { |value| -popularity(value) }
                                       .map { |hash_obj| hash_obj.values_at(*KEYS) }
    top.zero? ? table_rows : table_rows.take(top)
  end

  def append_names_transform
    Hash[info_hash.collect { |key, value| [key, value.merge(name: key)] }]
  end

  def popularity(info)
    sum = 0
    weights.each do |key, weight|
      sum += weight * info[key]
    end
    sum
  end
end
