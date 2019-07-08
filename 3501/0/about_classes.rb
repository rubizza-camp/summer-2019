require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutClasses < Neo::Koan
  class Dog
  end

  def test_instances_of_classes_can_be_created_with_new
    fido = Dog.new
    assert_equal Dog, fido.class
  end

  # ------------------------------------------------------------------

  class Dog2
    def name(a_name)
      @attr_name = a_name
    end
  end

  def test_instance_variables_can_be_set_by_assigning_to_them
    fido = Dog2.new
    assert_equal [], fido.instance_variables

    fido.name('Fido')
    assert_equal [:@attr_name], fido.instance_variables
  end

  def test_instance_variables_cannot_be_accessed_outside_the_class
    fido = Dog2.new
    fido.name('Fido')

    assert_raise(NoMethodError) do
      fido.attr_name
    end

    assert_raise(Exception) do
      eval <<-RUBY, binding, __FILE__, __LINE__ + 1
      fido.@name
      RUBY
      # NOTE: Using eval because the above line is a syntax error.
    end
  end

  def test_you_can_politely_ask_for_instance_variable_values
    fido = Dog2.new
    fido.name('Fido')

    assert_equal 'Fido', fido.instance_variable_get('@attr_name')
  end

  def test_you_can_rip_the_value_out_using_instance_eval
    fido = Dog2.new
    fido.name('Fido')

    assert_equal 'Fido', fido.instance_eval('@attr_name', __FILE__, __LINE__) # string version
    assert_equal 'Fido', (fido.instance_eval { @attr_name }) # block version
  end

  # ------------------------------------------------------------------

  class Dog3
    def name(a_name)
      @attr_name = a_name
    end

    attr_reader :attr_name
  end

  def test_you_can_create_accessor_methods_to_return_instance_variables
    fido = Dog3.new
    fido.name('Fido')

    assert_equal 'Fido', fido.attr_name
  end

  # ------------------------------------------------------------------

  class Dog4
    attr_reader :attr_name

    def name(a_name)
      @attr_name = a_name
    end
  end

  def test_attr_reader_will_automatically_define_an_accessor
    fido = Dog4.new
    fido.name('Fido')

    assert_equal 'Fido', fido.attr_name
  end

  # ------------------------------------------------------------------

  class Dog5
    attr_accessor :attr_name
  end

  def test_attr_accessor_will_automatically_define_both_read_and_write_accessors
    fido = Dog5.new

    fido.attr_name = 'Fido'
    assert_equal 'Fido', fido.attr_name
  end

  # ------------------------------------------------------------------

  class Dog6
    attr_reader :attr_name
    def initialize(initial_name)
      @attr_name = initial_name
    end
  end

  def test_initialize_provides_initial_values_for_instance_variables
    fido = Dog6.new('Fido')
    assert_equal 'Fido', fido.attr_name
  end

  def test_args_to_new_must_match_initialize
    assert_raise(ArgumentError) do
      Dog6.new
    end
    # THINK ABOUT IT:
    # Why is this so?
  end

  def test_different_objects_have_different_instance_variables
    fido = Dog6.new('Fido')
    rover = Dog6.new('Rover')

    assert_equal true, rover.attr_name != fido.attr_name
  end

  # ------------------------------------------------------------------

  class Dog7
    attr_reader :attr_name

    def initialize(initial_name)
      @attr_name = initial_name
    end

    def self
      self
    end

    def to_s
      @attr_name
    end

    def inspect
      "<Dog named '#{attr_name}'>"
    end
  end

  def test_inside_a_method_self_refers_to_the_containing_object
    fido = Dog7.new('Fido')

    fidos_self = fido.self
    assert_equal fido, fidos_self
  end

  def test_to_s_provides_a_string_version_of_the_object
    fido = Dog7.new('Fido')
    assert_equal 'Fido', fido.to_s
  end

  def test_to_s_is_used_in_string_interpolation
    fido = Dog7.new('Fido')
    assert_equal 'My dog is Fido', "My dog is #{fido}"
  end

  def test_inspect_provides_a_more_complete_string_version
    fido = Dog7.new('Fido')
    assert_equal "<Dog named 'Fido'>", fido.inspect
  end

  def test_all_objects_support_to_s_and_inspect
    array = [1, 2, 3]

    assert_equal '[1, 2, 3]', array.to_s
    assert_equal '[1, 2, 3]', array.inspect

    assert_equal 'STRING', 'STRING'.to_s
    assert_equal %(\"STRING\"), 'STRING'.inspect
  end
end
