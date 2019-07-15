# frozen_string_literal: true

class Setuper
  def initialize
    prepare
  end

  def init_options
    { gems: gem_names, name: name_pattern, top_n: top }
  end

  private

  def options
    @options ||= parse
  end

  def prepare
    locale_routine
  end

  def locale_routine
    I18n.load_path = Dir['./locales.yml']
    I18n.locale = YAML.load_file('default_locale.yaml')['locale'].to_sym
  end

  def gem_names
    @gem_names ||=
      begin
        YAML.load_file(options[:file] || 'example.yaml')['gems']
      rescue Errno::ENOENT
        puts I18n.t('no_file')
        exit
      rescue YamlSyntaxError
        put I18n.t('yaml_error')
        exit
      end
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
  rescue OptionParser::ParseError
    puts I18n.t('parse_error')
    exit
  end
end
