# frozen_string_literal: true

require_relative 'scanners/yml'

# some info
module Authentification
  include YamlScanner

  def registered?
    # session.delete(:student_id) # delete it later
    session.key?(:student_id)
  end

  def registrate(*)
    save_context :identification
    respond_with :message, text: "You have to authorise.\nWhat\'s your camp ID?"
  end

  def identification(*words)
    student_id = words[0].to_i
    if students_id.include?(student_id)
      update_session(student_id)
      respond_with :message, text: "You are authorised, number #{student_id}!"
    else
      respond_with :message, text: "I don't know who you are and what you want from me..."
    end
  end

  private

  def update_session(student_id)
    session[:student_id] = student_id
  end
end
