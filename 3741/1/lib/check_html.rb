require 'json'
# check url validate and return base html or nil object
class CheckHtml
  def call(gem_name)
    source_url = Kernel.open("https://rubygems.org/api/v1/gems/#{gem_name}.json").read
    JSON.parse(source_url)['source_code_uri']
  rescue OpenURI::HTTPError => errors
    p "#{gem_name} gem`s url status - " + errors.io.status * ', '
    nil
  end
end
