# rubocop: disable Lint/HandleExceptions, Metrics/MethodLength, Lint/UselessAssignment

require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutExceptions < Neo::Koan
  class MySpecialError < RuntimeError
  end

  def testexception
    assert_equal RuntimeError, MySpecialError.ancestors[1]
    assert_equal StandardError, MySpecialError.ancestors[2]
    assert_equal Exception, MySpecialError.ancestors[3]
    assert_equal Object, MySpecialError.ancestors[4]
  end

  #:reek:TooManyStatements:
  def test_rescue_clause
    # rubocop: enable Metrics/MethodLength
    result = nil
    begin
      raise 'Oops'
    rescue StandardError => exp
      result = :exception_handled
    end

    assert_equal :exception_handled, result
    assert_equal true, exp.is_a?(StandardError), 'Should be a Standard Error'
    assert_equal true, exp.is_a?(RuntimeError), 'Should be a Runtime Error'
    assert RuntimeError.ancestors.include?(StandardError),
           'RuntimeError is a subclass of StandardError'

    assert_equal 'Oops', e.message
  end

  # :reek:TooManyStatements:
  def test_raising_a_particular_error
    result = nil
    begin
      # 'raise' and 'fail' are synonyms
      raise MySpecialError, 'My Message'
    rescue MySpecialError => exp
      result = :exception_handled
    end

    assert_equal :exception_handled, result
    assert_equal 'My Message', exp.message
  end

  def test_ensure_clause
    result = nil
    # rubocop: enable Lint/UselessAssignment
    begin
      raise 'Oops'
    rescue StandardError
      # rubocop: enable Lint/HandleExceptions
      # no code here
    ensure
      result = :always_run
    end

    assert_equal :always_run, result
  end

  def test_asserting_an_error_is_raised
    assert_raise(MySpecialError) do
      raise MySpecialError, 'New instances can be raised directly.'
    end
  end
end
