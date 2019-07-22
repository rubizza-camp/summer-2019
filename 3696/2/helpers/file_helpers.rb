# frozen_string_literal: true

require 'fileutils'

module FileHelpers
  private

  def generate_path(name)
    "./public/#{user_id}/#{name}s/#{session[:utc]}/"
  end

  def create_path(name)
    path = generate_path(name)
    FileUtils.mkdir_p(path) unless File.exist?(path)
    path
  end
end
