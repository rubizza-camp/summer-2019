require File.expand_path(File.dirname(__FILE__) + '/neo')

# Project: Create a Proxy Class
#
# In this assignment, create a proxy class (one is started for you
# below).  You should be able to initialize the proxy object with any
# object.  Any messages sent to the proxy object should be forwarded
# to the target object.  As each message is sent, the proxy should
# record the name of the method sent.
#
# The proxy class is started for you.  You will need to add a method
# missing handler and any other supporting methods.  The specification
# of the Proxy class is given in the AboutProxyObjectProject koan.
# :reek:Attribute:
class Proxy
  attr_accessor :object, :messages
  def initialize(target_object)
    @object = target_object
    @messages = []
  end

  def called?(obj)
    @messages.include?(obj)
  end

  def number_of_times_called(obj)
    @messages.count(obj)
  end
  # rubocop: disable Style/MethodMissing

  def method_missing(name, *args, &block)
    @messages << name
    @object.send(name, *args, &block)
  end
end
# rubocop: enable Style/MethodMissing

# The proxy object should pass the following Koan:
#:reek:FeatureEnvy:reek:TooManyStatements:
class AboutProxyObjectProject < Neo::Koan
  def test_proxy_method_returns_wrapped_object
    # NOTE: The Television class is defined below
    television = Proxy.new(Television.new)

    # HINT: Proxy class is defined above, may need tweaking...

    assert television.instance_of?(Proxy)
  end

  def test_television_methods_still_perform_their_function
    television = Proxy.new(Television.new)

    television.channel = 10
    television.power

    assert_equal 10, television.channel
    assert television.on?
  end

  def test_proxy_records_messages_sent_to_television
    television = Proxy.new(Television.new)

    television.power
    television.channel = 10

    assert_equal %i[power channel=], television.messages
  end

  def test_proxy_handles_invalid_messages
    television = Proxy.new(Television.new)

    assert_raise(NoMethodError) do
      television.no_such_method
    end
  end

  def test_proxy_reports_methods_have_been_called
    television = Proxy.new(Television.new)

    television.power
    television.power

    assert television.called?(:power)
    assert !television.called?(:channel)
  end
  
  def test_proxy_counts_method_calls
    television = Proxy.new(Television.new)

    television.power
    television.channel = 48
    television.power

    assert_equal 2, television.number_of_times_called(:power)
    assert_equal 1, television.number_of_times_called(:channel=)
    assert_equal 0, television.number_of_times_called(:on?)
  end
  # :reek:FeatureEnvy:
  def test_proxy_can_record_more_than_just_tv_objects
    proxy = Proxy.new('Code Mash 2009')

    proxy.upcase!
    result = proxy.split

    assert_equal %w[CODE MASH 2009], result
    assert_equal %i[upcase! split], proxy.messages
  end
end

# ====================================================================
# The following code is to support the testing of the Proxy class.  No
# changes should be necessary to anything below this comment.

# Example class using in the proxy testing above.
# :reek:Attribute:reek:InstanceVariableAssumption:
class Television
  attr_accessor :channel

  def power
    @power = if @power == :on
               :off
             else
               :on
             end
  end

  def on?
    @power == :on
  end
end

# Tests for the Television class.  All of theses tests should pass.
#:reek:FeatureEnvy:reek:TooManyStatements:
class TelevisionTest < Neo::Koan
  def test_it_turns_on
    television = Television.new

    television.power
    assert television.on?
  end

  def test_it_also_turns_off
    television = Television.new

    television.power
    television.power

    assert !television.on?
  end

  def test_edge_case_on_off
    television = Television.new

    television.power
    television.power
    television.power

    assert television.on?

    television.power

    assert !television.on?
  end

  def test_can_set_the_channel
    television = Television.new

    television.channel = 11
    assert_equal 11, television.channel
  end
end
