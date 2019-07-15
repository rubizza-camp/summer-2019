class GemTerminalOutput
  def self.fetch_gem_terminal_output(gem)
    fetcher = new
    fetcher.fetch_gem_terminal_output(gem)
  end

  def fetch_gem_terminal_output(gem)
    @row = [gem.name,
            'used by' + fetch_gem_parameter(gem, :used_by),
            'watched by ' + fetch_gem_parameter(gem, :watch),
            fetch_gem_parameter(gem, :star) + ' stars',
            fetch_gem_parameter(gem, :forks) + ' forks',
            fetch_gem_parameter(gem, :contributors) + ' contributors',
            fetch_gem_parameter(gem, :issues) + ' issues']
  end

  private

  def fetch_gem_parameter(gem, parameter)
    gem.parameters[parameter].to_s
  end
end
