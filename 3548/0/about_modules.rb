# frozen_string_literal: true

require File.expand_path(File.dirname(__FILE__) + '/neo')
# Class about modules
# :reek:FeatureEnvy
class AboutModules < Neo::Koan
  # comment for nameable
  module Nameable
    def name_set(new_name)
      @name = new_name
    end

    def here
      :in_module
    end
  end

  def test_cant_instantiate_modules
    assert_raise(NoMethodError) do
      Nameable.new
    end
  end
  # ------------------------------------------------------------------
  # Class dog
  class Dog
    include Nameable

    attr_reader :name

    def initialize
      @name = 'Fido'
    end

    def bark
      'WOOF'
    end

    def here
      :in_object
    end
  end

  def test_normal_methods_are_available_in_the_object
    fido = Dog.new
    assert_equal 'WOOF', fido.bark
  end

  def test_module_methods_are_also_available_in_the_object
    fido = Dog.new
    assert_nothing_raised do
      fido.name_set('Rover')
    end
  end

  def test_module_methods_can_affect_instance_variables_in_the_object
    fido = Dog.new
    assert_equal 'Fido', fido.name
    fido.name_set('Rover')
    assert_equal 'Rover', fido.name
  end

  def test_classes_can_override_module_methods
    fido = Dog.new
    assert_equal :in_object, fido.here
  end
end
