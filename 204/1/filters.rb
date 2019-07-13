# :reek:UtilityFunction
# :reek:NilCheck:
module Filters
  def filter_by_name(data, name)
    data['gems'] = data['gems'].grep(/#{name}/) unless name.nil?
    data['gems']
  end

  def filter_by_top(result, top = nil)
    result = result.first(top) unless top.nil?
    result
  end

  def sort_by_popularity(result)
    result = result.sort_by { |_, value| value[:popularity] }.reverse
    result.to_h
  end
end
