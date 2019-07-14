require 'yaml'

system ("gem list > ./tmp/gems.txt")


$db_file = 'gems.yml'
array = File.readlines('./tmp/gems.txt')

array.map! { |el| el.split(/\s[[default:]*|[\W\d\W]]*/) }.flatten!

RAILS = %w[actioncable actionmailbox actionmailer actionpack actiontext
  actionview activejob activemodel activerecord activestorage
  activesupport]

BOO = %w[boostrap-sass]

COFFEESCRIPT = %w[coffee-script-source]

def replace(el)
  return 'rails' if RAILS.include?(el)
  return 'bootstrap' if BOO.include?(el)
  return 'coffee-script' if COFFEESCRIPT.include?(el)
  el
end

array.map! { |el| replace(el) }



seq = { 'gem' => array.uniq! }

f = File.open($db_file, 'w')
f.write seq.to_yaml
f.close
