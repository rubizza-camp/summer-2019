require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutExceptions < Neo::Koan
  class MySpecialError < RuntimeError
  end

  # :reek:UncommunicativeMethodName
  def test_exceptions_inherit_from_exception
    assert_equal RuntimeError, MySpecialError.ancestors[1]
    assert_equal StandardError, MySpecialError.ancestors[2]
    assert_equal Exception, MySpecialError.ancestors[3]
    assert_equal Object, MySpecialError.ancestors[4]
  end

  # rubocop:disable MethodLength
  # :reek:TooManyStatements
  def test_rescue_clause
    result = nil
    begin
      raise 'Oops'
    rescue StandardError => exex
      result = :exception_handled
    end
    # rubocop:enable MethodLength

    assert_equal :exception_handled, result

    assert_equal true, exex.is_a?(StandardError), 'Should be a Standard Error'
    assert_equal true, exex.is_a?(RuntimeError),  'Should be a Runtime Error'

    assert RuntimeError.ancestors.include?(StandardError),
           'RuntimeError is a subclass of StandardError'

    assert_equal 'Oops', exex.message
  end

  # :reek:TooManyStatements
  def test_raising_a_particular_error
    result = nil
    begin
      # 'raise' and 'fail' are synonyms
      raise MySpecialError, 'My Message'
    rescue MySpecialError => exex
      result = :exception_handled
    end

    assert_equal :exception_handled, result
    assert_equal 'My Message', exex.message
  end

  # rubocop:disable UselessAssignment
  # rubocop:disable HandleExceptions
  def test_ensure_clause
    result = nil
    begin
      raise 'Oops'
    rescue StandardError
      # no code here
    ensure
      result = :always_run
    end

    assert_equal :always_run, result
  end
  # rubocop:enable UselessAssignment
  # rubocop:enable HandleExceptions

  # Sometimes, we must know about the unknown
  def test_asserting_an_error_is_raised
    # A do-end is a block, a topic to explore more later
    assert_raise(StandardError) do
      raise MySpecialError, 'New instances can be raised directly.'
    end
  end
end
