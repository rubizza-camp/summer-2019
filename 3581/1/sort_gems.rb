class SortGems
  class << self
    def sort_top(hash_gems, add_args)
      summ(hash_gems)
      return  hash_gems.sort_by { |_, val| -val['sum'] }[0..add_args['top'] - 1].to_h if add_args['top']
      hash_gems.sort_by { |_, val| -val['sum'] }.to_h
    end

    private

    def summ(hash_gems)
      hash_gems.each do |_, gem_param|
        sum = gem_param['used_by'] + gem_param['watch'] + gem_param['star'] + gem_param['fork'] + gem_param['contrib']
        gem_param['sum'] = sum
      end
    end
  end
end
