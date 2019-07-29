# frozen_string_literal: true

require 'ohm'
class User < Ohm::Model
  attribute :name
  attribute :person_number
  attribute :checkin_datetime
  attribute :checkout_datetime
  attribute :checked_in
  attribute :telegram_id

  index :id
  index :telegram_id
  index :person_number

  def self.person_number_exists?(person_number)
    !find(person_number: person_number).first.nil?
  end

  def save
    return unless valid_person_number?

    super
  end

  def checked_out?
    !checked_in
  end

  def checked_in?
    checked_in
  end

  private

  def valid_person_number?
    File.open('./data/users.yml', 'r').read.split("\n").include?(person_number)
  end
end
