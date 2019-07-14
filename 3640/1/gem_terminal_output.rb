class GemTerminalOutput
  # rubocop: disable Metrics/AbcSize
  def self.get_gem_terminal_output(geme)
    @row = [geme.name,
            'used by' + geme.parameters[:used_by].to_s,
            'watched by ' + geme.parameters[:watch].to_s,
            geme.parameters[:star].to_s + ' stars',
            geme.parameters[:forks].to_s + ' forks',
            geme.parameters[:contributors].to_s + ' contributors',
            geme.parameters[:issues].to_s + ' issues']
  end
  # rubocop: enable Metrics/AbcSize
end
