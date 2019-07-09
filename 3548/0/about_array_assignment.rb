# frozen_string_literal: true

require File.expand_path(File.dirname(__FILE__) + '/neo')
# About array assignment
class AboutArrayAssignment < Neo::Koan
  def test_non_parallel_assignment
    names = %w[John Smith]
    assert_equal %w[John Smith], names
  end

  def test_parallel_assignments
    first_name, last_name = %w[John Smith] # rubocop:disable Style/ParallelAssignment
    assert_equal 'John', first_name
    assert_equal 'Smith', last_name
  end

  def test_parallel_assignments_with_extra_values
    first_name, last_name = %w[John Smith III]
    assert_equal 'John', first_name
    assert_equal 'Smith', last_name
  end

  def test_parallel_assignments_with_splat_operator
    first_name, *last_name = %w[John Smith III]
    assert_equal 'John', first_name
    assert_equal %w[Smith III], last_name
  end

  def test_parallel_assignments_with_too_few_variables
    first_name, last_name = %w[Cher]
    assert_equal 'Cher', first_name
    assert_equal nil, last_name
  end

  def test_parallel_assignments_with_subarrays
    first_name, last_name = [%w[Willie Rae], 'Johnson'] # rubocop:disable Style/ParallelAssignment
    assert_equal %w[Willie Rae], first_name
    assert_equal 'Johnson', last_name
  end

  def test_parallel_assignment_with_one_variable
    first_name, = %w[John Smith]
    assert_equal 'John', first_name
  end

  def test_swapping_with_parallel_assignment
    first_name = 'Roy'
    last_name = 'Rob'
    first_name, last_name = last_name, first_name
    assert_equal 'Rob', first_name
    assert_equal 'Roy', last_name
  end
end
