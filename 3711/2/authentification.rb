# frozen_string_literal: true

require_relative 'scanners/yml'

module Authentification
  include YamlScanner

  def registered?
    session.key?(:student_id)
  end

  def registrate
    save_context :identification
    respond_with :message, text: "You have to authorise.\nWhat\'s your camp ID?"
  end

  def identification(student_id)
    if students_id.include?(student_id.to_i)
      update_session(student_id)
      respond_with :message, text: "You are authorised, number #{student_id}!"
    else
      respond_with :message, text: "I don't know a student with such ID."
      respond_with :message, text: 'Use /start command to try again.'
    end
  end

  private

  def update_session(student_id)
    session[:student_id] = student_id
  end
end
