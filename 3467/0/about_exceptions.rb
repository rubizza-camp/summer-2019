<<<<<<< HEAD
=======
# rubocop:disable Lint/UnneededCopDisableDirective
# rubocop:disable Lint/HandleExceptions, Metrics/MethodLength

>>>>>>> ecc5273a98f21b47f778c5467994ffd510a3139d
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

<<<<<<< HEAD
=======
  # rubocop:disable TooManyStatements
>>>>>>> ecc5273a98f21b47f778c5467994ffd510a3139d
  def test_rescue_clause
    result = nil
    begin
      raise 'Oops'
<<<<<<< HEAD
    rescue StandardError => e
=======
    rescue StandardError => err
>>>>>>> ecc5273a98f21b47f778c5467994ffd510a3139d
      result = :exception_handled
    end

    assert_equal :exception_handled, result

<<<<<<< HEAD
    assert_equal true, e.is_a?(StandardError), 'Should be a Standard Error'
    assert_equal true, e.is_a?(RuntimeError),  'Should be a Runtime Error'
=======
    assert_equal true, err.is_a?(StandardError), 'Should be a Standard Error'
    assert_equal true, err.is_a?(RuntimeError),  'Should be a Runtime Error'
>>>>>>> ecc5273a98f21b47f778c5467994ffd510a3139d

    assert RuntimeError.ancestors.include?(StandardError),
           'RuntimeError is a subclass of StandardError'

<<<<<<< HEAD
    assert_equal 'Oops', e.message
=======
    assert_equal 'Oops', err.message
>>>>>>> ecc5273a98f21b47f778c5467994ffd510a3139d
  end

  def test_raising_a_particular_error
    result = nil
    begin
      # 'raise' and 'fail' are synonyms
      raise MySpecialError, 'My Message'
<<<<<<< HEAD
    rescue MySpecialError => e
=======
    rescue MySpecialError => err
>>>>>>> ecc5273a98f21b47f778c5467994ffd510a3139d
      result = :exception_handled
    end

    assert_equal :exception_handled, result
<<<<<<< HEAD
    assert_equal 'My Message', e.message
  end
=======
    assert_equal 'My Message', err.message
  end
  # rubocop:enable TooManyStatements
>>>>>>> ecc5273a98f21b47f778c5467994ffd510a3139d

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
<<<<<<< HEAD
=======

# rubocop:enable Lint/HandleExceptions, Metrics/MethodLength
# rubocop:enable Lint/UnneededCopDisableDirective
>>>>>>> ecc5273a98f21b47f778c5467994ffd510a3139d
