# Create table
class TableCreator
  def create(obj)
    table = Terminal::Table.new do |tab|
      tab.rows = obj
      tab.style = { border_top: false, border_bottom: false }
    end
    puts table
  end
end
