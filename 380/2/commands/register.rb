class Register
  attr_reader :user, :tg_id

  def initialize(tg_id)
    @tg_id = tg_id
  end

  def call(camp_id)
    if in_list?(camp_id)
      user = User.new(tg_id, camp_id)
      user.save_status(:checked_out)
      "Welcome to camp, Comrade No #{camp_id}!"
    else
      'Your ID is not in the list! Enter valid camp id!'
    end
  end

  private

  def in_list?(camp_id)
    file ||= 'lib/camp_ids.yml'
    camp_list = YAML.load_file(file).fetch('camp_ids', [])
    camp_list.include?(camp_id)
  end
end
