require 'yaml'

system ("gem list > ./tmp/gems.txt")


$db_file = 'gems.yml'
array = File.readlines('./tmp/gems.txt')

array.map! { |el| el.split(/\s[[default:]*|[\W\d\W]]*/) }.flatten!

p array
seq = { 'gem' => array }

f = File.open($db_file, 'w')
f.write seq.to_yaml
f.close
