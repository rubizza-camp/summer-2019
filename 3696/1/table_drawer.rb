# frozen_string_literal: true

require './scraper'
require 'terminal-table'
class TableDrawer
  PATH_TO_WEIGHTS = 'weights.yaml'
  KEYS = %i[name watches stars forks contributors issues used_by].freeze

  def draw(data_to_display)
    hash, top = data_to_display
    puts Terminal::Table.new headings: [I18n.t('name'), I18n.t('watches'), I18n.t('stars'),
                                        I18n.t('forks'), I18n.t('contributors'),
                                        I18n.t('issues'), I18n.t('used_by')], rows: rows(hash, top)
  end

  private

  attr_reader :info_hash, :top

  def weights
    @weights ||= YAML.load_file(PATH_TO_WEIGHTS)['weights']
                     .transform_keys(&:to_sym)
  end

  def rows(hash, top)
    table_rows = append_names_transform(hash).values.sort_by { |value| -popularity(value) }
                                             .map { |hash_obj| hash_obj.values_at(*KEYS) }
    top.zero? ? table_rows : table_rows.take(top)
  end

  def append_names_transform(info_hash)
    Hash[info_hash.collect { |key, value| [key, value.merge(name: key)] }]
  end

  def popularity(info)
    weights.sum do |key, weight|
      weight * info[key]
    end
  end
end
