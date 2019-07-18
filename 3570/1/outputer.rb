# frozen_string_literal: true

class Outputer
  TABLE_HEADER = ['gem', 'used by', 'watched by', 'stars', 'forks', 'contributors', 'issues'].freeze

  def initialize(gems_info)
    @gems_info = gems_info
  end

  def print
    puts Terminal::Table.new(
      headings: TABLE_HEADER,
      rows: rows
    )
  end

  private

  def rows
    @gems_info.map do |gems_info|
      gems_info.values_at(:name, :used_by, :watched_by, :stars, :forks,
                          :contributors, :issues)
    end
  end
end
