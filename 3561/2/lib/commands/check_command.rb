# frozen_string_literal: true

module CheckCommands
  TIME_NOW = Time.now.strftime('%d.%m.%Y %H:%M').to_s

  def checkin!(*)
    check('true', 'checkin')
  end

  def checkout!(*)
    check('false', 'checkout')
  end

  def check(in_camp, command_name)
    @in_camp = in_camp
    if find_user.first.in_camp == @in_camp
      respond_with :message, text: 'You have location problems.'
    else
      user_check(command_name)
    end
  rescue NoMethodError
    respond_with :message, text: 'For me, you do not exist. Dial /start.'
  end

  private

  def user_check(command_name)
    if payload['photo']
      action_after_photo_sent(command_name)
    elsif payload['location']
      action_after_location_sent(command_name)
    else
      save_context "#{command_name}!".to_sym
      respond_with :message, text: 'Send a selfie.'
    end
  end

  def action_after_photo_sent(command_name)
    PhotoManager.new.request_file_path(payload['photo'].last['file_id'],
                                       "public/#{find_user_for_geo}/#{command_name}s/#{TIME_NOW}/")
    save_context "#{command_name}!".to_sym
    respond_with :message, text: 'You are beautiful. Throw off your location.'
  end

  def action_after_location_sent(command_name)
    if GeoManager.in_camp?(payload['location'])
      user_in_camp(command_name)
    else
      save_context "#{command_name}!".to_sym
      respond_with :message, text: 'You are not no place. Start from the beginning.'
    end
  end

  def user_in_camp(command_name)
    respond_with :message, text: 'Great)'
    find_user.first.update(in_camp: 'true')
    GeoManager.save_geo(payload['location'],
                        "public/#{find_user_for_geo}/#{command_name}s/#{TIME_NOW}/geo.txt")
  end

  def find_user
    User.find(telegram_id: from['id'].to_s)
  end

  def find_user_for_geo
    find_user.first.number_in_camp
  end
end
