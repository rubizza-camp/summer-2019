# frozen_string_literal: true

require_relative './util'
require 'yaml'

module LoginCommand
  include Util

  def login!(*)
    if registered?
      respond_with :message, text: 'Stop doing this! You are already registered'
      return
    end
    respond_with :message, text: 'What\'s your number?'
    save_context :getting_number
  end

  def getting_number(*answer)
    number = answer.first.to_i
    check_number number
  rescue NoMethodError
    respond_with :message, text: 'Send number!'
    save_context :getting_number
  end

  def check_number(number)
    case group number
    when :used
      respond_with :message, text: 'This number has already been used to login'
    when :online
      respond_with :message, text: 'First you need to get into the offline group'
    when :offline
      register(number)
    end
  end

  def group(number)
    return :used if redis.get(number)
    return :online if numbers[:online].include?(number)
    return :offline if numbers[:offline].include?(number)

    respond_with :message, text: 'Incorrect number, try again'
    save_context :getting_number
  end

  def register(number)
    session[:number] = number
    session[:state] = redis.get("#{number} state") || :out
    session[:state] = session[:state].to_sym
    redis.set(number, id)
    respond_with :message, text: 'You\'ve successfully logged in'
  end

  def numbers
    unless @numbers
      file = YAML.load_file('./data/users.yml')
      @numbers = { online: file['online'].map(&:to_i), offline: file['offline'].map(&:to_i) }
    end
    @numbers
  end
end
