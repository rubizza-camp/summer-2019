class ParseOption
  attr_reader :arg

  def initialize
    @arg = {
      top: 0,
      name: '',
      file: File.join(__dir__, 'data', 'gem.yml')
    }
  end

  def self.call
    new.call
  end

  def call
    parser
    arg
  end

  private

  def parser
    OptionParser.new do |opt|
      top_argument(opt)
      file_argument(opt)
      name_argument(opt)
    end.parse!(into: arg)
  end

  def top_argument(opt)
    opt.on('--top TOP', 'Number of items displayed')
  end

  def file_argument(opt)
    opt.on('--file FILE', 'Path to file')
  end

  def name_argument(opt)
    opt.on('--name NAME', 'Word that find in gems name')
  end
end
