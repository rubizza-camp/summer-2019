require 'minitest/autorun'

class Dog4
	attr_reader :name

    	def a_name(a_name)
	      	@name = a_name
	end
end

class TestMyClass < Minitest::Test
	

  def test_attr_reader_will_automatically_define_an_accessor
    fido = Dog4.new
    fido.a_name('Fido')

    assert_equal 'Fido', fido.name
  end
end
