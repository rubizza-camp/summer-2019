# frozen_string_literal: true

require File.expand_path(File.dirname(__FILE__) + '/neo')

# :reek:Attribute
# :reek:UncommunicativeMethodName
# :reek:TooManyMethods
class AboutClassMethods < Neo::Koan
  class Dog; end

  def test_objects_are_objects
    fido = Dog.new
    assert_equal true, fido.is_a?(Object)
  end

  def test_classes_are_classes
    assert_equal true, Dog.is_a?(Class)
  end

  def test_classes_are_objects_too
    assert_equal true, Dog.is_a?(Object)
  end

  # :reek:FeatureEnvy
  def test_objects_have_methods
    fido = Dog.new
    assert fido.methods.any? == true
  end

  def test_classes_have_methods
    assert Dog.methods.any? == true
  end

  def test_you_can_define_methods_on_individual_objects
    fido = Dog.new
    def fido.wag
      :fidos_wag
    end
    assert_equal :fidos_wag, fido.wag
  end

  def test_other_objects_are_not_affected_by_these_singleton_methods
    fido = Dog.new
    rover = Dog.new

    def fido.wag
      :fidos_wag
    end

    assert_raise(NoMethodError) do
      rover.wag
    end
  end

  # ------------------------------------------------------------------
<<<<<<< HEAD
<<<<<<< HEAD
  # :reek:UncommunicativeModuleName
  class Dachshund
=======

  class DogSecond
>>>>>>> fix about_class_methods
=======
  # :reek:UncommunicativeModuleName
  class Dog2
>>>>>>> Revert "fix about_class_methods"
    def wag
      :instance_level_wag
    end
  end

<<<<<<< HEAD
<<<<<<< HEAD
  def Dachshund.wag
=======
  def DogSecond.wag
>>>>>>> fix about_class_methods
=======
  def Dog2.wag
>>>>>>> Revert "fix about_class_methods"
    :class_level_wag
  end

  def test_since_classes_are_objects_you_can_define_singleton_methods_on_them_too
<<<<<<< HEAD
<<<<<<< HEAD
    assert_equal :class_level_wag, Dachshund.wag
  end

  def test_class_methods_are_independent_of_instance_methods
    fido = Dachshund.new
    assert_equal :instance_level_wag, fido.wag
    assert_equal :class_level_wag, Dachshund.wag
=======
    assert_equal :class_level_wag, DogSecond.wag
=======
    assert_equal :class_level_wag, Dog2.wag
>>>>>>> Revert "fix about_class_methods"
  end

  def test_class_methods_are_independent_of_instance_methods
    fido = Dog2.new
    assert_equal :instance_level_wag, fido.wag
<<<<<<< HEAD
    assert_equal :class_level_wag, DogSecond.wag
>>>>>>> fix about_class_methods
=======
    assert_equal :class_level_wag, Dog2.wag
>>>>>>> Revert "fix about_class_methods"
  end

  # ------------------------------------------------------------------
  class Dog
    attr_reader :name
  end

  def test_classes_and_instances_do_not_share_instance_variables
    fido = Dog.new
    @name = 'Fido'
    assert_equal nil, fido.name
    assert_equal 'AboutClassMethods::Dog', Dog.name
  end

  # ------------------------------------------------------------------

  class Dog
    def self.a_class_method
      :dogs_class_method
    end
  end

  def test_you_can_define_class_methods_inside_the_class
    assert_equal :dogs_class_method, Dog.a_class_method
  end

  # ------------------------------------------------------------------

  LAST_EXPRESSION = class Dog
                      21
                    end

  def test_class_statements_return_the_value_of_their_last_expression
    assert_equal 21, LAST_EXPRESSION
  end

  # ------------------------------------------------------------------

  SELF_INSIDE_OF_CLASS_STATEMENT = class Dog
                                     self
                                   end

  def test_self_while_inside_class_is_class_object_not_instance
    assert_equal true, Dog == SELF_INSIDE_OF_CLASS_STATEMENT
  end

  # ------------------------------------------------------------------

  class Dog
    def self.another_class_method
      :another_way_to_write_class_methods
    end
  end

  def test_you_can_use_self_instead_of_an_explicit_reference_to_dog
    assert_equal :another_way_to_write_class_methods, Dog.another_class_method
  end

  # ------------------------------------------------------------------

  class Dog
    class << self
      def another_dog_class_method
        :still_another_way
      end
    end
  end

  def test_heres_still_another_way_to_write_class_methods
    assert_equal :still_another_way, Dog.another_dog_class_method
  end

  # THINK ABOUT IT:
  #
  # The two major ways to write class methods are:
  #   class Demo
  #     def self.method
  #     end
  #
  #     class << self
  #       def class_methods
  #       end
  #     end
  #   end
  #
  # Which do you prefer and why?
  # Are there times you might prefer one over the other?

  # ------------------------------------------------------------------

  def test_heres_an_easy_way_to_call_class_methods_from_instance_methods
    fido = Dog.new
    assert_equal :still_another_way, fido.class.another_dog_class_method
  end
end
