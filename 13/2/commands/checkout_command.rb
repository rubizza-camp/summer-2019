# frozen_string_literal: true

require_relative 'base_command'
# class process /checkout input
class CheckoutCommand < BaseCommand
  def call
    return unless user.state.to_sym == :wait_checkout

    user.state = :wait_checkout_location
   end
 end
