require 'yaml'
m = 0
file = YAML.safe_load(File.read('Data/camp_participants.yaml'))
file['participents'].each do |participant|
  puts participant['telegram_id']
  puts "---"
end
File.open('Data/camp_participants.yaml','w') do |h| 
   h.write file.to_yaml
end
puts '--//--'
puts file['participents'].inspect
