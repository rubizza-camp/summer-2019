module Validation
  module Selfie
    def selfie?
      payload['photo']
    end
  end
end
