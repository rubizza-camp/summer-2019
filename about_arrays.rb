require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutArrays < Neo::Koan
  def test_creating_arrays
    empty_array = []
    assert_equal Array, empty_array.class
    assert_equal 0, empty_array.size
  end

  # :reek:TooManyStatements
  def test_array_literals
    array = []
    assert_equal [], array

    array[0] = 1
    assert_equal [1], array

    array[1] = 2
    assert_equal [1, 2], array

    array << 333
    assert_equal [1, 2, 333], array
  end

  # :reek:TooManyStatements
  def test_accessing_array_elements
    array = %i[peanut butter and jelly]

    assert_equal :peanut, array[0]
    assert_equal :peanut, array.first
    assert_equal :jelly, array[3]
    assert_equal :jelly, array.last
    assert_equal :jelly, array[-1]
    assert_equal :butter, array[-3]
  end

  # :reek:TooManyStatements
  def test_slicing_arrays
    array = %i[peanut butter and jelly]

    assert_equal %i[peanut], array[0, 1]
    assert_equal %i[peanut butter], array[0, 2]
    assert_equal %i[and jelly], array[2, 2]
    assert_equal %i[and jelly], array[2, 20]
    assert_equal [], array[4, 0]
    assert_equal [], array[4, 100]
    assert_equal nil, array[5, 0]
  end

  def test_arrays_and_ranges
    assert_equal Range, (1..5).class
    assert_not_equal [1, 2, 3, 4, 5], (1..5)
    assert_equal [1, 2, 3, 4, 5], (1..5).to_a
    assert_equal [1, 2, 3, 4], (1...5).to_a
  end

  def test_slicing_with_ranges
    array = %i[peanut butter and jelly]

    assert_equal %i[peanut butter and], array[0..2]
    assert_equal %i[peanut butter], array[0...2]
    assert_equal %i[and jelly], array[2..-1]
  end

  # :reek:TooManyStatements
  def test_pushing_and_popping_arrays
    array = [1, 2]
    array.push(:last)

    assert_equal [1, 2, :last], array

    popped_value = array.pop
    assert_equal :last, popped_value
    assert_equal [1, 2], array
  end

  # :reek:TooManyStatements
  def test_shifting_arrays
    array = [1, 2]
    array.unshift(:first)

    assert_equal [:first, 1, 2], array

    shifted_value = array.shift
    assert_equal :first, shifted_value
    assert_equal [1, 2], array
  end
end
