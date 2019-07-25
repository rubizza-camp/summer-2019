module Commands
  module Start
    def start!(*)
      notify(:already_registered) && return if registered?

      notify(:number_request)
      save_context(:number_check)
    end

    def number_check(number, *)
      notify(:failure) && return unless FileAccessor.personal_numbers.include?(number)
      register(number)
      notify(:success_registration)
    end

    private

    def register(number)
      session[:number] = number
      session[:id] = from['id']
      session[:checked_in] = false
    end
  end
end
