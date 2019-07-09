<<<<<<< HEAD
=======
# rubocop:disable Lint/UnneededCopDisableDirective
# rubocop:disable Style/EvalWithLocation

>>>>>>> ecc5273a98f21b47f778c5467994ffd510a3139d
require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutClasses < Neo::Koan
  class Dog
  end

  def test_instances_of_classes_can_be_created_with_new
    fido = Dog.new
    assert_equal Dog, fido.class
  end

  # ------------------------------------------------------------------

<<<<<<< HEAD
  class Dog2
=======
  class DogTwo
>>>>>>> ecc5273a98f21b47f778c5467994ffd510a3139d
    def put_name(a_name)
      @name = a_name
    end
  end

  def test_instance_variables_can_be_set_by_assigning_to_them
<<<<<<< HEAD
    fido = Dog2.new
=======
    fido = DogTwo.new
>>>>>>> ecc5273a98f21b47f778c5467994ffd510a3139d
    assert_equal [], fido.instance_variables

    fido.put_name('Fido')
    assert_equal [:@name], fido.instance_variables
  end

  def test_instance_variables_cannot_be_accessed_outside_the_class
<<<<<<< HEAD
    fido = Dog2.new
=======
    fido = DogTwo.new
>>>>>>> ecc5273a98f21b47f778c5467994ffd510a3139d
    fido.put_name('Fido')

    assert_raise(NoMethodError) do
      fido.name
    end

    assert_raise(NoMethodError) do
      eval 'fido.name'
      # NOTE: Using eval because the above line is a syntax error.
    end
  end

  def test_you_can_politely_ask_for_instance_variable_values
<<<<<<< HEAD
    fido = Dog2.new
=======
    fido = DogTwo.new
>>>>>>> ecc5273a98f21b47f778c5467994ffd510a3139d
    fido.put_name('Fido')

    assert_equal 'Fido', fido.instance_variable_get('@name')
  end

  def test_you_can_rip_the_value_out_using_instance_eval
<<<<<<< HEAD
    fido = Dog2.new
=======
    fido = DogTwo.new
>>>>>>> ecc5273a98f21b47f778c5467994ffd510a3139d
    fido.put_name('Fido')

    assert_equal 'Fido', fido.instance_eval('@name') # string version
    assert_equal 'Fido', (fido.instance_eval { @name }) # block version
  end

  # ------------------------------------------------------------------

<<<<<<< HEAD
  class Dog3
=======
  class DogThree
>>>>>>> ecc5273a98f21b47f778c5467994ffd510a3139d
    def put_name(a_name)
      @name = a_name
    end

    attr_reader :name
  end

  def test_you_can_create_accessor_methods_to_return_instance_variables
<<<<<<< HEAD
    fido = Dog3.new
=======
    fido = DogThree.new
>>>>>>> ecc5273a98f21b47f778c5467994ffd510a3139d
    fido.put_name('Fido')

    assert_equal 'Fido', fido.name
  end

  # ------------------------------------------------------------------

<<<<<<< HEAD
  class Dog4
=======
  class DogFour
>>>>>>> ecc5273a98f21b47f778c5467994ffd510a3139d
    attr_reader :name

    def put_name(a_name)
      @name = a_name
    end
  end

  def test_attr_reader_will_automatically_define_an_accessor
<<<<<<< HEAD
    fido = Dog4.new
=======
    fido = DogFour.new
>>>>>>> ecc5273a98f21b47f778c5467994ffd510a3139d
    fido.put_name('Fido')

    assert_equal 'Fido', fido.name
  end

  # ------------------------------------------------------------------

<<<<<<< HEAD
  class Dog5
=======
  class DogFive
>>>>>>> ecc5273a98f21b47f778c5467994ffd510a3139d
    attr_accessor :name
  end

  def test_attr_accessor_will_automatically_define_both_read_and_write_accessors
<<<<<<< HEAD
    fido = Dog5.new
=======
    fido = DogFive.new
>>>>>>> ecc5273a98f21b47f778c5467994ffd510a3139d

    fido.name = 'Fido'
    assert_equal 'Fido', fido.name
  end

  # ------------------------------------------------------------------

<<<<<<< HEAD
  class Dog6
=======
  class DogSix
>>>>>>> ecc5273a98f21b47f778c5467994ffd510a3139d
    attr_reader :name
    def initialize(initial_name)
      @name = initial_name
    end
  end

  def test_initialize_provides_initial_values_for_instance_variables
<<<<<<< HEAD
    fido = Dog6.new('Fido')
=======
    fido = DogSix.new('Fido')
>>>>>>> ecc5273a98f21b47f778c5467994ffd510a3139d
    assert_equal 'Fido', fido.name
  end

  def test_args_to_new_must_match_initialize
    assert_raise(ArgumentError) do
<<<<<<< HEAD
      Dog6.new
=======
      DogSix.new
>>>>>>> ecc5273a98f21b47f778c5467994ffd510a3139d
    end
    # THINK ABOUT IT:
    # Why is this so?
  end

  def test_different_objects_have_different_instance_variables
<<<<<<< HEAD
    fido = Dog6.new('Fido')
    rover = Dog6.new('Rover')
=======
    fido = DogSix.new('Fido')
    rover = DogSix.new('Rover')
>>>>>>> ecc5273a98f21b47f778c5467994ffd510a3139d

    assert_equal true, rover.name != fido.name
  end

  # ------------------------------------------------------------------

<<<<<<< HEAD
  class Dog7
=======
  class DogSeven
>>>>>>> ecc5273a98f21b47f778c5467994ffd510a3139d
    attr_reader :name

    def initialize(initial_name)
      @name = initial_name
    end

    def take_self
      self
    end

    def to_s
      @name
    end

    def inspect
      "<Dog named '#{name}'>"
    end
  end

  def test_inside_a_method_self_refers_to_the_containing_object
<<<<<<< HEAD
    fido = Dog7.new('Fido')
=======
    fido = DogSeven.new('Fido')
>>>>>>> ecc5273a98f21b47f778c5467994ffd510a3139d

    fidos_self = fido.take_self
    assert_equal fido, fidos_self
  end

  def test_to_s_provides_a_string_version_of_the_object
<<<<<<< HEAD
    fido = Dog7.new('Fido')
=======
    fido = DogSeven.new('Fido')
>>>>>>> ecc5273a98f21b47f778c5467994ffd510a3139d
    assert_equal 'Fido', fido.to_s
  end

  def test_to_s_is_used_in_string_interpolation
<<<<<<< HEAD
    fido = Dog7.new('Fido')
=======
    fido = DogSeven.new('Fido')
>>>>>>> ecc5273a98f21b47f778c5467994ffd510a3139d
    assert_equal 'My dog is Fido', "My dog is #{fido}"
  end

  def test_inspect_provides_a_more_complete_string_version
<<<<<<< HEAD
    fido = Dog7.new('Fido')
=======
    fido = DogSeven.new('Fido')
>>>>>>> ecc5273a98f21b47f778c5467994ffd510a3139d
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
<<<<<<< HEAD
=======
# rubocop:enable Style/EvalWithLocation
# rubocop:enable Lint/UnneededCopDisableDirective
>>>>>>> ecc5273a98f21b47f778c5467994ffd510a3139d
