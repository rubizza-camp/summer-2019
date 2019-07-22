require_relative '../data_check'

module Commands
  module Checkin
    include DataCheck

    def checkin!(*)
      notify(:not_registered) && return unless registered?
      notify(:not_checkout) && return unless checkout?

      process_checkin
      notify(:success_check_start)
    end

    def checkin_ending
      notify(:success_checkin_end)
      set_checkin_flags
    end

    private

    def process_checkin
      session[:command] = 'checkin'
      session[:timestamp] = Time.now.getutc.to_i
      save_context :photo_check
    end

    def set_checkin_flags
      session[:checkin?] = true
      session[:checkout?] = false
    end
  end
end
