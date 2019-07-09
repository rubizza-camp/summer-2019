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
  # rubocop:disable Metrics/MethodLength
  # :reek:TooManyStatements

  def test_rescue_clause
    result = nil
    begin
      # rubocop:disable Style/SignalException
      fail 'Oops'
      # rubocop:enable Style/SignalException
    rescue StandardError => ex
      result = :exception_handled
    end

    assert_equal :exception_handled, result

    assert_equal true, ex.is_a?(StandardError), 'Should be a Standard Error'
    assert_equal true, ex.is_a?(RuntimeError),  'Should be a Runtime Error'
    # rubocop:disable Metrics/LineLength
    assert RuntimeError.ancestors.include?(StandardError), 'RuntimeError is a subclass of StandardError'
    # rubocop:enable Metrics/LineLength
    assert_equal 'Oops', ex.message
  end
  # :reek:TooManyStatements

  def test_raising_a_particular_error
    result = nil
    begin
      # 'raise' and 'fail' are synonyms
      raise MySpecialError, 'My Message'
    rescue MySpecialError => ex
      result = :exception_handled
    end

    assert_equal :exception_handled, result
    assert_equal 'My Message', ex.message
  end
  # rubocop:enable Metrics/MethodLength

  def test_ensure_clause
    # rubocop:disable Lint/UselessAssignment
    result = nil
    # rubocop:enable Lint/UselessAssignment
    begin
      # rubocop:disable Style/SignalException
      fail 'Oops'
    # rubocop:enable Style/SignalException
    # rubocop:disable Lint/HandleExceptions
    rescue StandardError
      # no code here
    ensure
      result = :always_run
    end
    # rubocop:enable Lint/HandleExceptions
    assert_equal :always_run, result
  end

  # Sometimes, we must know about the unknown
  def test_asserting_an_error_is_raised
    # rubocop:disable Style/RaiseArgs
    assert_raise(MySpecialError) do
      raise MySpecialError.new('New instances can be raised directly.')
    end
    # rubocop:enable Style/RaiseArgs
  end
end
