module Contexts
  module PhotoCheck
    def photo_check(*)
      proceed_to_geo_check && return if photo?
      notify_with_reference(:photo_check_failure)
      save_context(:photo_check)
    end

    private

    def proceed_to_geo_check
      Storage.save_photo(session, payload)
      notify(:photo_check_success)
      save_context(:geo_check)
    end

    def photo?
      payload['photo']
    end
  end
end
