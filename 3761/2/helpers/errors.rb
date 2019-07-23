module Errors
  class NoGeolocationError < StandardError; end

  class NoPhotoError < StandardError; end

  class FarFromCampError < StandardError; end

  class InvalidNumberError < StandardError; end

  class StudentExistError < StandardError; end
end
