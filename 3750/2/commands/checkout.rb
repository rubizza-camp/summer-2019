module Commands
  module Checkout
    def checkout!(*)
      notify(:not_registered) && return unless registered?
      notify(:not_checkin) && return unless checkin?

      process_checkout
      notify(:success_check_start)
    end

    def checkout_ending
      notify(:success_checkout_end)
      send_sticker(:farewell_sticker)
      set_checkout_flags
    end

    private

    def process_checkout
      session[:command] = 'checkout'
      session[:timestamp] = Time.now.getutc.to_i
      save_context :photo_check
    end

    def set_checkout_flags
      session[:checkin?] = false
      session[:checkout?] = true
    end
  end
end
