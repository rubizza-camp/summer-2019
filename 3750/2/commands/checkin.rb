module Commands
  module Checkin
    def checkin!(*)
      notify(:not_registered) && return unless registered?
      notify(:not_checked_out) && return unless checked_out?

      process_checkin
    end

    private

    def process_checkin
      session[:command] = 'checkin'
      session[:timestamp] = Time.now.getutc.to_i
      notify(:success_check_start)
      save_context(:photo_check)
    end
  end
end
