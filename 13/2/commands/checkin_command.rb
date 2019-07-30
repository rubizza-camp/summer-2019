 # frozen_string_literal: true
 
require_relative 'base_command'
# class process /checkin input
class CheckinCommand < BaseCommand
  def call
    return unless user.state.to_sym == :wait_checkin

    user.state = :wait_location
   end
 end
