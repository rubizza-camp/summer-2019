# frozen_string_literal: true

require 'yaml'
require_relative '../entities/cadet'

class CadetRegistration
  CADETS_LIST_PATH = './data/numbers.yml'

  attr_reader :cadet_number, :telegram_id

  def initialize(cadet_number, telegram_id)
    @cadet_number = cadet_number
    @telegram_id = telegram_id
  end

  def call
    validate_if_cadet_in_list
    validate_if_cadet_uniq

    new_cadet.save unless new_cadet.error
    new_cadet
  end

  private

  def new_cadet
    @new_cadet ||= Cadet.new(cadet_number, telegram_id)
  end

  def cadets_list
    @cadets_list ||= YAML.load_file(CADETS_LIST_PATH)['numbers'].map(&:to_i)
  end

  def validate_if_cadet_in_list
    new_cadet.error = 'Ты не в списках, принцесса' unless cadets_list.include?(new_cadet.id.to_i)
  end

  def validate_if_cadet_uniq
    registered_cadet = Cadet.find(new_cadet.id)
    new_cadet.error = 'Под этим номер уже зарегестрированы' if registered_cadet
  end
end
