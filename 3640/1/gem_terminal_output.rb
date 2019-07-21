module CreateGemRow
  def create_gem_row_terminal_output(gem)
    [gem.name,
     "used by #{gem.parameters[:used_by]}",
     "watched by #{gem.parameters[:watch]}",
     "#{gem.parameters[:star]} stars",
     "#{gem.parameters[:forks]} forks",
     "#{gem.parameters[:contributors]} contributors",
     "#{gem.parameters[:issues]} issues"]
  end
  module_function :create_gem_row_terminal_output
end
