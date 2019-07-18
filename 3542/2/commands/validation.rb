module Validation
  def valid_number?(number)
    (exist? number) && (not_used? number)
  end

  def exist?(number)
    File.open('data/numbers.txt').each do |file_number|
      return true if number == file_number.gsub(/[^0-9]/, '')
    end
    false
  end

  def used?(number)
    session.each { |_, user| return true if user['number'] == number}
    false
  end

  def not_used?(number)
    !used? number
  end

  def registered?
    session[session_key]
  end

  def selfie?
    payload['photo']
  end

  def geo?
    return false unless payload['location']
    valid_latitude? && valid_longitude?
  end

  def valid_latitude?
    (53.914264..53.916233).include? payload['location']['latitude']
  end

  def valid_longitude?
    (27.565941..27.571306).include? payload['location']['longitude']
  end

  def checkin?
    session[session_key]['checkin']
  end

  def not_checkin?
    !checkin?
  end
end
