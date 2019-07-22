module Commands
  module Start
    def start!(*)
      notify(:already_registered) && return if registered?

      process_registration
      notify(:number_request)
    end

    def number_check(number, *)
      notify(:failure) && return unless FileAccessor.personal_numbers.include? number
      registration(number)
    end

    private

    def process_registration
      save_context :number_check
    end

    def registration(number)
      session[:number] = number
      session[:id] = from['id']
      session[:checkout?] = true
      Redis.new.set(number, from['id'])
      notify(:success_registration)
    end
  end
end
