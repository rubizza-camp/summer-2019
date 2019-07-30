# frozen_string_literal: true

require_relative 'base_command'
# class process /start input
class StartCommand < BaseCommand
  def call
    return unless user.state == :wait_start

    user.state = :wait_number
   end
 end
