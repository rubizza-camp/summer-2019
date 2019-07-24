class User < Ohm::Model
  attribute :telegram_id
  attribute :number
  attribute :in_camp

  unique :telegram_id
  unique :number

  def self.create_student(telegram_id, student_number)
    create(
      telegram_id: telegram_id,
      number: student_number,
      in_camp: 'false'
    )
  end

  def self.registered?(telegram_id)
    with(:telegram_id, telegram_id)
  end

  def self.validate_student_number(student_number)
    return 'Этот номер уже занят!' if with(:number, student_number)
    return 'Такого номера не существует.' if STUDENT_NUMBERS.exclude?(student_number.to_i)

    nil
  end
end
