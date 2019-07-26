# frozen_string_literal: true

#saves photo in .jpg format
module Photo
  def self.save(bot, photo_id, student, timestamp, folder)
    file_path = bot.api.get_file(file_id: photo_id).dig('result', 'file_path')
    Kernel.open("https://api.telegram.org/file/bot#{TOKEN}/#{file_path}") do |image|
      File.open("public/#{student}/#{folder}/#{timestamp}/selfie.jpg", 'wb') { |file| file.write(image.read) }
    end
  end
end
