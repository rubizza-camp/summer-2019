module Errors
  class UnregisteredStudentError < StandardError; end

  class NoGeolocationError < StandardError; end

  class NoPhotoError < StandardError; end

  class FarFromCampError < StandardError; end

  class InvalidNumberError < StandardError; end

  class StudentAlreadyExistError < StandardError; end
end
