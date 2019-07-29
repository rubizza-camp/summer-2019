# frozen_string_literal: false

# rubocop:disable Lint/UnneededCopDisableDirective, Style/MethodMissing
# rubocop:disable Style/MethodMissingSuper, Style/MissingRespondToMissing, Style/SingleLineMethods

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

# :reek:Attribute
class Proxy
  attr_accessor :messages

  def initialize(target_object)
    @messages = []
    @object = target_object
  end

  def number_of_times_called(method_name)
    @messages.count method_name
  end

  def called?(method_name)
    @messages.include? method_name
  end

  def method_missing(method_name, *args, &block)
    @messages << method_name
    @object.send(method_name, *args, &block)
  end
end

# The proxy object should pass the following Koan:
#
class AboutProxyObjectProject < Neo::Koan
  def test_proxy_method_returns_wrapped_object
    # NOTE: The Television class is defined below
    tv = Proxy.new(Television.new)

    # HINT: Proxy class is defined above, may need tweaking...

    assert tv.instance_of?(Proxy)
  end

  # :reek:FeatureEnvy
  def test_tv_methods_still_perform_their_function
    tv = Proxy.new(Television.new)

    tv.channel = 10
    tv.power

    assert_equal 10, tv.channel
    assert tv.on?
  end

  # :reek:FeatureEnvy
  def test_proxy_records_messages_sent_to_tv
    tv = Proxy.new(Television.new)

    tv.power
    tv.channel = 10

    assert_equal %i[power channel=], tv.messages
  end

  def test_proxy_handles_invalid_messages
    tv = Proxy.new(Television.new)

    assert_raise(NoMethodError) do
      tv.no_such_method
    end
  end

  # :reek:FeatureEnvy
  def test_proxy_reports_methods_have_been_called
    tv = Proxy.new(Television.new)

    tv.power
    tv.power

    assert tv.called?(:power)
    assert !tv.called?(:channel)
  end

  # :reek:FeatureEnvy
  # :reek:TooManyStatements
  def test_proxy_counts_method_calls
    tv = Proxy.new(Television.new)

    tv.power
    tv.channel = 48
    tv.power

    assert_equal 2, tv.number_of_times_called(:power)
    assert_equal 1, tv.number_of_times_called(:channel=)
    assert_equal 0, tv.number_of_times_called(:on?)
  end

  # :reek:FeatureEnvy
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
# :reek:Attribute
# :reek:FeatureEnvy
# :reek:InstanceVariableAssumption
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
# :reek:FeatureEnvy
class TelevisionTest < Neo::Koan
  def test_it_turns_on
    tv = Television.new

    tv.power
    assert tv.on?
  end

  # :reek:FeatureEnvy
  def test_it_also_turns_off
    tv = Television.new

    tv.power
    tv.power

    assert !tv.on?
  end

  # :reek:TooManyStatements
  def test_edge_case_on_off
    tv = Television.new

    tv.power
    tv.power
    tv.power

    assert tv.on?

    tv.power

    assert !tv.on?
  end

  # :reek:FeatureEnvy
  def test_can_set_the_channel
    tv = Television.new

    tv.channel = 11
    assert_equal 11, tv.channel
  end
end

# rubocop:enable Style/MethodMissingSuper, Style/MissingRespondToMissing, Style/SingleLineMethods
# rubocop:enable Lint/UnneededCopDisableDirective, Style/MethodMissing
