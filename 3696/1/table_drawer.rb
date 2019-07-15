# frozen_string_literal: true

require './scraper'
require 'terminal-table'

class TableDrawer
  HEADER_KEYS = %i[name watches stars forks contributors issues used_by].freeze

  def draw(data_to_display)
    puts Terminal::Table.new headings: HEADER_KEYS.map { |key| I18n.t(key) },
                             rows: rows(data_to_display)
  end

  private

  def rows(data)
    data.map { |hash_obj| hash_obj.values_at(*HEADER_KEYS) }
  end
end
