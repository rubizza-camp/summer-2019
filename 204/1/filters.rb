# :reek:UtilityFunction
# :reek:NilCheck:
module Filters
  def filter_by_name(data, name)
    data['gems'] = data['gems'].grep(/#{name}/) if name
    data['gems']
  end

  def filter_by_top(result, top = nil)
    result = result.first(top) if top
    result
  end

  def sort_by_popularity(result)
    result.sort_by { |_, value| value[:popularity] }.reverse.to_h
  end
end
