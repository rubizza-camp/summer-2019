# rubocop:disable  all
# frozen_string_literal: true

require File.expand_path(File.dirname(__FILE__) + '/neo')
# This shiny device polishes bared foos
#:reek:TooManyStatements 
class AboutExceptions < Neo::Koan
  # This shiny device polishes bared foos
  class MySpecialError < RuntimeError
  end

  def test_exceptions_inherit_from_exception
    assert_equal RuntimeError, MySpecialError.ancestors[1]
    assert_equal StandardError, MySpecialError.ancestors[2]
    assert_equal Exception, MySpecialError.ancestors[3]
    assert_equal Object, MySpecialError.ancestors[4]
  end

  def test_rescue_clause
    result = nil
    begin
      fail 'Oops'
    rescue StandardError => expe
      result = :exception_handled
    end

    assert_equal :exception_handled, result

    assert_equal true, expe.is_a?(StandardError), 'Should be a Standard Error'
    assert_equal true, expe.is_a?(RuntimeError),  'Should be a Runtime Error'

    assert RuntimeError.ancestors.include?(StandardError),
           'RuntimeError is a subclass of StandardError'

    assert_equal 'Oops', expe.message
  end

  def test_raising_a_particular_error
    result = nil
    begin
      # 'raise' and 'fail' are synonyms
      raise MySpecialError, 'My Message'
    rescue MySpecialError => expe
      result = :exception_handled
    end

    assert_equal :exception_handled, result
    assert_equal 'My Message', expe.message
  end

  def test_ensure_clause
    result = nil
    begin
      fail 'Oops'
    rescue StandardError
      # no code here
    ensure
      result = :always_run
    end

    assert_equal :always_run, result
  end

  # Sometimes, we must know about the unknown
  def test_asserting_an_error_is_raised
    # A do-end is a block, a topic to explore more later
    assert_raise(MySpecialError) do
      raise MySpecialError.new('New instances can be raised directly.')
    end
  end
end
