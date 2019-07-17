# frozen_string_literal: true

# rubocop:disable Style/EvalWithLocation

require File.expand_path(File.dirname(__FILE__) + '/neo')

# :reek:Attribute
# :reek:FeatureEnvy
# :reek:TooManyStatements
# :reek:UncommunicativeModuleName

FIDO = 'Fido'
# :reek:InstanceVariableAssumption
# :reek:TooManyMethods
class AboutClasses < Neo::Koan
  class Dog; end

  def test_instances_of_classes_can_be_created_with_new
    fido = Dog.new
    assert_equal Dog, fido.class
  end

  # ------------------------------------------------------------------

  class Dachshund
    def give_name(a_name)
      @name = a_name
    end
  end
  # :reek:FeatureEnvy
  def test_instance_variables_can_be_set_by_assigning_to_them
    fido = Dachshund.new
    assert_equal [], fido.instance_variables

    fido.give_name(FIDO)
    assert_equal [:@name], fido.instance_variables
  end

  # :reek:TooManyStatements
  def test_instance_variables_cannot_be_accessed_outside_the_class
    fido = Dachshund.new
    fido.give_name(FIDO)

    assert_raise(NoMethodError) do
      fido.name
    end

    assert_raise(SyntaxError) do
      eval 'fido.@name'
      # NOTE: Using eval because the above line is a syntax error.
    end
  end

  # :reek:FeatureEnvy
  def test_you_can_politely_ask_for_instance_variable_values
    fido = Dachshund.new
    fido.give_name(FIDO)

    assert_equal FIDO, fido.instance_variable_get('@name')
  end

  def fido_eval(fido)
    fido.instance_eval { @name }
  end

  def test_you_can_rip_the_value_out_using_instance_eval
    fido = Dachshund.new
    fido.give_name('Fido')

    assert_equal FIDO, fido.instance_eval('@name') # string version
    assert_equal FIDO, fido_eval(fido) # block version
  end

  # ------------------------------------------------------------------

  class Bassethound
    def give_name(a_name)
      @name = a_name
    end

    attr_reader :name
  end

  # :reek:FeatureEnvy
  def test_you_can_create_accessor_methods_to_return_instance_variables
    fido = Bassethound.new
    fido.give_name(FIDO)

    assert_equal FIDO, fido.name
  end

  # ------------------------------------------------------------------

  class Retriever
    attr_reader :name

    def give_name(a_name)
      @name = a_name
    end
  end
  # :reek:FeatureEnvy
  def test_attr_reader_will_automatically_define_an_accessor
    fido = Retriever.new
    fido.give_name(FIDO)

    assert_equal FIDO, fido.name
  end

  # ------------------------------------------------------------------
  # :reek:FeatureEnvy
  # :reek:Attribute
  class Poodle
    attr_accessor :name
  end
  # :reek:FeatureEnvy
  def test_attr_accessor_will_automatically_define_both_read_and_write_accessors
    fido = Poodle.new
    fido.name = FIDO
    assert_equal FIDO, fido.name
  end

  # ------------------------------------------------------------------

  class Doberman
    attr_reader :name

    def initialize(initial_name)
      @name = initial_name
    end
  end

  def test_initialize_provides_initial_values_for_instance_variables
    fido = Doberman.new(FIDO)
    assert_equal FIDO, fido.name
  end

  def test_args_to_new_must_match_initialize
    assert_raise(ArgumentError) do
      Doberman.new
    end
  end

  def test_different_objects_have_different_instance_variables
    fido = Doberman.new(FIDO)
    rover = Doberman.new('Rover')

    assert_equal true, rover.name != fido.name
  end

  # ------------------------------------------------------------------

  class Bulldog
    attr_reader :name

    def initialize(initial_name)
      @name = initial_name
    end

    def self_method
      self
    end

    def to_s
      name
    end

    def inspect
      "<Dog named '#{name}'>"
    end
  end
  # :reek:FeatureEnvy
  def test_inside_a_method_self_refers_to_the_containing_object
    fido = Bulldog.new(FIDO)

    fidos_self = fido.self_method
    assert_equal fido.self_method, fidos_self
  end

  def test_to_s_provides_a_string_version_of_the_object
    fido = Bulldog.new(FIDO)
    assert_equal FIDO, fido.to_s
  end

  def test_to_s_is_used_in_string_interpolation
    fido = Bulldog.new(FIDO)
    assert_equal 'My dog is Fido', "My dog is #{fido}"
  end

  def test_inspect_provides_a_more_complete_string_version
    fido = Bulldog.new(FIDO)
    assert_equal "<Dog named 'Fido'>", fido.inspect
  end

  def test_all_objects_support_to_s_and_inspect
    array = [1, 2, 3]

    assert_equal '[1, 2, 3]', array.to_s
    assert_equal '[1, 2, 3]', array.inspect

    assert_equal 'STRING', 'STRING'.to_s
    assert_equal '"STRING"', 'STRING'.inspect
  end
end
# rubocop:enable Style/EvalWithLocation
