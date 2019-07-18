class GemsTable
  def initialize(gems)
    @gems = gems
  end

  def call
    representation
  end

  private

  def representation
    @gems.map(&method(:format_gem))
  end

  def format_gem(gem)
    "#{gem_field_value(gem, :name)} |" \
      " used by #{gem_field_value(gem, :used_by)} |" \
      " watched by #{gem_field_value(gem, :watchers_count)} |" \
      " #{gem_field_value(gem, :stargazers_count)} stars |" \
      " #{gem_field_value(gem, :forks_count)} forks |" \
      " #{gem_field_value(gem, :contributors)} contributors |" \
      " #{gem_field_value(gem, :open_issues)} issues |"
  end

  def gem_field_value(gem, key)
    gem[key].to_s.ljust(col_size[key]).to_s
  end

  def col_size
    @col_size ||= count_column_sizes
  end

  def count_column_sizes
    @gems.first.keys.reduce({}) do |acc, key|
      acc.merge(key => count_size_for_column(key))
    end
  end

  def count_size_for_column(key)
    @gems.map { |el| el[key].to_s.length }.max
  end
end
