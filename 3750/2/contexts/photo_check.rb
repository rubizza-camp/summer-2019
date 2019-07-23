module Contexts
  module PhotoCheck
    def photo_check(*)
      proceed_to_geo_check && return if photo?
      notify_with_reference(:photo_check_failure)
      save_context(:photo_check)
    end

    private

    def proceed_to_geo_check
      photo_save
      notify(:photo_check_success)
      save_context(:geo_check)
    end

    def photo?
      payload['photo']
    end

    def create_path
      path = PathGenerator.new(session, payload).save_path
      FileUtils.mkdir_p(path) unless File.exist?(path)

      path
    end

    def photo_save
      File.open(create_path + 'photo.jpg', 'wb') do |file|
        file << URI.open(PathGenerator.new(session, payload).download_path).read
      end
    end
  end
end
