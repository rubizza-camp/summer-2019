class Score
  def call(arr)
    # working on normalization
    @weights = { used_by: 10, watch: 4, star: 8, fork: 6, contrib: 1, issues: 2 }
    @criteria = @weights.keys
    @gems_hash = make_hash(arr)
    @gems_hash_with_p = calculate_popularity(@gems_hash)
    arr.each do |g|
      g.popularity = @hash_g[g.name]
    end
  end

  def make_hash(arr)
    @hash_g = {}

    arr.each do |g|
      h = {}
      @hash_g[g.name] = h
      @criteria.each do |c|
        h[c] = g.send(c)
      end
    end
    @hash_g
  end

  def calculate_popularity(_hash_g)
    @hash_g.each do |gem_n, crit|
      crit.each do |crit_name, crit_value|
        crit[crit_name] = crit_value * @weights[crit_name]
      end
      @hash_g[gem_n] = crit.values.reduce(:+).round(2)
    end
    @hash_g
  end
end
