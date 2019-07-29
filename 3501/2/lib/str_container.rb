# frozen_string_literal: true

require 'json'

class StrContainer
  class << self
    attr_reader :strings
    def initialize_strings
      @strings = JSON.parse(File.read('source/strings.json'))
    end

    def respond_to_missing?(method_name)
      method_name.to_s.start_with?('user_') || super
    end

    def method_missing(method_name)
      strings.fetch(method_name.to_s, 'Undefined string') || super
    end

    def welcome_old(user_name)
      "Привет, #{user_name}. Рад видеть вас снова!"
    end

    def registred_new(user_name)
      "Добро пожаловать, #{user_name} в Rubizza survival camp!"
    end
  end
end
