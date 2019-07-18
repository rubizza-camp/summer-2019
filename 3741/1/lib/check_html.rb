require 'json'

class CheckHtml
  def call(gem_name)
    begin
      source_url = Kernel.open("https://rubygems.org/api/v1/gems/#{gem_name}.json").read
      html = JSON.parse(source_url)['source_code_uri']
    rescue OpenURI::HTTPError => errors
      p "#{gem_name} gem`s url status - " + errors.io.status * ', '
      return nil
    end
    html
  end
end