module Commands
  module Checkout
    def checkout!(*)
      notify(:not_registered) && return unless registered?
      notify(:not_checked_in) && return unless checked_in?

      process_checkout
    end

    private

    def process_checkout
      session[:command] = 'checkout'
      session[:timestamp] = Time.now.getutc.to_i
      notify(:success_check_start)
      save_context(:photo_check)
    end
  end
end
