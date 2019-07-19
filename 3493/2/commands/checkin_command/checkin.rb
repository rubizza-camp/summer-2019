require_relative '../../models/user.rb'
require_relative '../../file_manager.rb'
require 'date'
require 'time'

module CheckinCommand
  def checkin!(*)
    if User[from['id']]
      if payload['photo']
        respond_with :message, text: "Получила фотку терь кинь гео"
        FileManager.request_file_path(payload['photo'].last['file_id'], User[from['id']].person_number, 'checkins')
        save_context :checkin!
      elsif payload['location']
        if is_camp?(payload['location']) 
          respond_with :message, text: "Зачекинила"
          FileManager.save_location_in_file(payload['location'], User[from['id']].person_number, 'checkins')
          User[from['id']].update(checkin_datetime: Time.now, is_checkin: true)
        else
          respond_with :message, text: "Наебать решил?"
        end
      else
        save_context :checkin!
        respond_with :message, text: 'Отправь-ка селфи'
      end
    else
      respond_with :message, text: "Сначала start"
    end

  end 

  def is_camp?(location)
    (53.914264.. 53.916233).include?(location['latitude'].to_f) && (27.565941..27.571306).include?(location['longitude'].to_f)
  end
end