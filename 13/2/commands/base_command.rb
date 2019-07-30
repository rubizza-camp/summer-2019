# frozen_string_literal: true

# base class 
class BaseCommand
  attr_reader :user

  def initialize(user)
    @user = user
  end
end
