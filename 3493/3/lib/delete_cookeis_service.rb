class DeleteCookiesService
  def self.delete_cookies(*keys)
    keys.each { |key| cookies.delete(key) }
  end
end
