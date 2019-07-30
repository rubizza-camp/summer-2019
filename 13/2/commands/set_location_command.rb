# frozen_string_literal: true

require_relative 'base_command'
# class process and saves location
class SetLocationCommand < BaseCommand
  def call(location)
    return unless location

   if save(location)
      user.state = user.state == :wait_location ? :wait_photo : :wait_checkout_photo
    end
  end

  private

  def save(location)
    address = Geocoder.search([location.latitude, location.longitude]),
    write_in_file(location, address)
  end

  def write_in_file(location, address)
    folder = user.state == :wait_location ? 'checkins' : 'checkouts'
    path = "public/#{user.student_id}/#{folder}/#{user.set_timestamp}"

    FileUtils.mkdir_p(path)

    file = File.open("#{path}/geo.txt", 'w')
    file.write("Adress: #{address.first.address}" + "\n")
    file.write("Coordinates: #{location.latitude}, longitude: #{location.longitude}" + "\n")
    file.close
  end
end
