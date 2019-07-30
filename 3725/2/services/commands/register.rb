# frozen_string_literal: true

module Commands
  class Register
    def self.perform(payload, &block)
      new(payload).perform(&block)
    end

    attr_reader :payload

    def initialize(payload)
      @payload = payload
    end

    def perform(&_block)
      check_registered
      check_number
      yield message, save_context if block_given?
    end

    private

    def check_registered
      message = :successfully_registered
      save_context = false
    end

    def check_number
      message = :invalid_number
      save_context = true unless create_user
    end

    def create_user
      User.create(telegram_id: telegram_id, name: name, person_number: person_number)
    end

    def person_number
      payload['text']
    end

    def telegram_id
      payload.dig('chat', 'id')
    end

    def name
      payload.dig('chat', 'first_name')
    end
  end
end
