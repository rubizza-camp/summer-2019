# rubocop:disable Lint/HandleExceptions, Metrics/MethodLength
require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutExceptions < Neo::Koan
  class MySpecialError < RuntimeError
  end

  def test_exceptions_inherit_from_exception
    assert_equal RuntimeError, MySpecialError.ancestors[1]
    assert_equal StandardError, MySpecialError.ancestors[2]
    assert_equal Exception, MySpecialError.ancestors[3]
    assert_equal Object, MySpecialError.ancestors[4]
  end

  # :reek:TooManyStatements
  def test_rescue_clause
    result = nil
    begin
      raise 'Oops'
    rescue StandardError => error
      result = :exception_handled
    end

    assert_equal :exception_handled, result

    assert_equal true, error.is_a?(StandardError), 'Should be a Standard Error'
    assert_equal true, error.is_a?(RuntimeError),  'Should be a Runtime Error'

    assert RuntimeError.ancestors.include?(StandardError),
           'RuntimeError is a subclass of StandardError'

    assert_equal 'Oops', error.message
  end

  # :reek:TooManyStatements
  def test_raising_a_particular_error
    result = nil
    begin
      # 'raise' and 'fail' are synonyms
      raise MySpecialError, 'My Message'
    rescue MySpecialError => error
      result = :exception_handled
    end

    assert_equal :exception_handled, result
    assert_equal 'My Message', error.message
  end

  def test_ensure_clause
    begin
      raise 'Oops'
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
      raise MySpecialError, 'New instances can be raised directly.'
    end
  end
end
# rubocop:enable Lint/HandleExceptions, Metrics/MethodLength
