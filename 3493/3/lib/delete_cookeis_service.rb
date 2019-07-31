class DeleteCookiesService
  def self.delete_cookies(*keys)
    require 'pry';binding.pry
    keys.each { |key| cookies.delete(key) }
  end
end