# frozen_string_literal: true

module CheckinCommand
  TIME_NOW = Time.now.strftime('%d.%m.%Y %H:%M').to_s

  def checkin!(*)
    if User.all.select { |user| user.telegram_id == from['id'].to_s }.first.in_camp == 'true'
      respond_with :message, text: 'Ты уже в офисе, отстань от меня'
    else
      user_checkin
    end
  rescue NoMethodError
    respond_with :message, text: 'Для меня тебя не существует. Набери /start'
  end

  private

  def user_checkin
    if payload['photo']
      action_after_photo_sent
    elsif payload['location']
      action_after_location_sent
    else
      save_context :checkin!
      respond_with :message, text: 'Отправь-ка селфи'
    end
  end

  def action_after_photo_sent
    PhotoManager.new.request_file_path(payload['photo'].last['file_id'],
                                       "public/#{find_user}/checkins/#{TIME_NOW}/")
    save_context :checkin!
    respond_with :message, text: 'А ты красивый). Скинь гео, позязя.'
  end

  def action_after_location_sent
    if GeoManager.in_camp?(payload['location'])
      user_in_camp
    else
      save_context :checkin!
      respond_with :message, text: 'Пидманщик. Ты не на месте...Жду следующее селфи'
    end
  end

  def user_in_camp
    respond_with :message, text: 'Отлично)'
    User.all.select { |user| user.telegram_id == from['id'].to_s }.first.update(in_camp: 'true')
    GeoManager.save_geo(payload['location'], "public/#{find_user}/checkins/#{TIME_NOW}/geo.txt")
  end

  def find_user
    User.all.select { |user| user.telegram_id == from['id'].to_s }.first.number_in_camp
  end
end
