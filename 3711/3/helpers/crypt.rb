require 'digest/md5'

module CryptHelper
  def md5_encrypt(message)
    Digest::MD5.hexdigest(message)
  end
end
