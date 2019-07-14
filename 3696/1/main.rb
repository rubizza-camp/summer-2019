require 'yaml'
require 'open-uri'
require 'optparse'
require './table_drawer'
require 'i18n'
require './info_source'
class Main
  def initialize(setup_class, source_parser_class, presenter_class)
    @setuper = setup_class
    @source_parser = source_parser_class
    @presenter = presenter_class
  end

  def run
    starter = setuper.new
    starter.prepare
    presenter.new.draw(source_parser.instance.data(starter.init_options))
  end

  private

  attr_reader :setuper, :source_parser, :presenter
end
