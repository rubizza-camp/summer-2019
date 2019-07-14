class GemTerminalOutput
  # rubocop: disable Metrics/AbcSize
  def self.get_gem_terminal_output(gem)
    @row = [gem.name,
            'used by' + gem.parameters[:used_by].to_s,
            'watched by ' + gem.parameters[:watch].to_s,
            gem.parameters[:star].to_s + ' stars',
            gem.parameters[:forks].to_s + ' forks',
            gem.parameters[:contributors].to_s + ' contributors',
            gem.parameters[:issues].to_s + ' issues']
  end
  # rubocop: enable Metrics/AbcSize
end
