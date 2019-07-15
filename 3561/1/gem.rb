class GemEntity
  attr_reader :gem_parameters, :name

  def initialize(gem_parameters:, name:)
    @gem_keys = %i[name used_by watchers stars forks contributors issues]
    @gem_parameters = gem_parameters
    @name = name
  end

  def to_str
    @gem_keys.each do |key|
      case_to_write_information(key)
    end
  end

  private

  def case_to_write_information(key)
    case key
    when :name
      printf format('%-8s |', @name)
    when :watchers, :used_by
      printf format(' %<name>s %-6<count>s |', name: key.to_s, count: @gem_parameters[key])
    else
      printf format(' %-8<count>s %<name>s |', count: @gem_parameters[key], name: key.to_s)
    end
  end
end
