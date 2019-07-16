module Models
  class GemModel
    attr_reader :gem_hash

    def initialize(name, url)
      @gem_hash = { name: name, url: url, count_watched: 0, count_stars: 0, count_forks: 0,
                    count_issues: 0, count_contributors: 0 }
    end

    def save_count_used_by(count_used_by)
      @gem_hash[:count_used_by] = count_used_by.to_i
    end

    def install_fields(args)
      @gem_hash[:count_watched] = args[0].to_i
      @gem_hash[:count_stars] = args[1].to_i
      @gem_hash[:count_forks] = args[2].to_i
      @gem_hash[:count_issues] = args[3].to_i
      @gem_hash[:count_contributors] = args[4].to_i
    end
  end
end
