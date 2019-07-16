# Create table
class TableCreator
  def create(obj)
    table = Terminal::Table.new do |tab|
      tab.rows = obj
    end
    puts table
  end
end
