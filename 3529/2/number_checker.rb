module NumberChecker

  def update_file(file_path, file)
    File.open(file_path,'w') do |h| 
        h.write file.to_yaml
    end
  end

  def handle_number(file_path, number)
    file = YAML.safe_load(File.read(file_path))
    resp = ''
    puts number.inspect
    file['participents'].each do |participant|
      if (number == participant.keys.first.to_s)
        resp = check_id(participant, number)
      end
    end
    update_file(file_path, file)
    return resp
  end

  def check_id(participant, number)
    resp = ''
    if participant['telegram_id'].nil?
      resp = "You've just signed in your camp database. We are watching you!!!"
      participant['telegram_id'] = payload['from']['id']
    else
      resp = "I'm sorry, but someone already have signed in with #{number} number"
    end
    return resp
  end
end
