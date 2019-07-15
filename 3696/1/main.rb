require 'yaml'
require 'open-uri'
require 'optparse'
require './table_drawer'
require 'i18n'
require './repo_adapter'
class Main
  def initialize(setup_class, source_parser_class, presenter_class)
    @setuper = setup_class
    @source_parser = source_parser_class
    @presenter = presenter_class
  end

  def run
    starter = setuper.new
    presenter.new.draw(source_parser.new(starter.init_options).data)
  end

  private

  attr_reader :setuper, :source_parser, :presenter
end
