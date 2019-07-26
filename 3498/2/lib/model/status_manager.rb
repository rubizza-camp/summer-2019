module StatusManager
  STATUS = { in: 1, out: 2 }.freeze

  def in_camp?
    status == STATUS[:in].to_s
  end

  def check_in
    update(status: STATUS[:in])
  end

  def check_out
    update(status: STATUS[:out])
  end
end
