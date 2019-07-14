class Setuper
  def initialize
    @options = parse
  end

  def prepare
    locale_routine
  end

  def init_options
    { gems: gem_names, name: name_pattern, top_n: top }
  end

  private

  attr_reader :options

  def locale_routine
    I18n.load_path = Dir['./locales.yml']
    I18n.locale = YAML.load_file('default_locale.yaml')['locale'].to_sym
  end

  def gem_names
    @gem_names ||= YAML.load_file(options[:file] || 'example.yaml')['gems']
  end

  def name_pattern
    @name_pattern ||= options[:name] || ''
  end

  def top
    @top ||= options[:top].to_i
  end

  def create_parser
    OptionParser.new do |opt|
      opt.on('--top TOP')
      opt.on('--name NAME')
      opt.on('--file FILE')
    end
  end

  def parse
    options = {}
    create_parser.parse!(into: options)
    options
  end
end
