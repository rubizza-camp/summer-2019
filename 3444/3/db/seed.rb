require './app.rb'

class Seed
  def self.setup
    clean_db
    sleep 3
    add_values_to_db
  end

  def self.seed
    add_values_to_db
  end

  def self.drop
    clean_db
  end

  def self.clean_db
    Bar.all.each(&:destroy)
    Comment.all.each(&:destroy)
    User.all.each(&:destroy)
  end

  def self.add_values_to_db
    create_bars_n_comments
    puts "Created #{Bar.all.count} bars"
    puts "Created #{Comment.all.count} comments"
    User.create(useremail: 'test@test.com', password: 'test')
    puts 'Created User => useremail: \'test@test.com\', password:\'test\''
  end

  def self.create_bars_n_comments
    20.times do |iter|
      params = { id: iter + 1, title: Faker::Name.name,
                 description: Faker::Restaurant.type,
                 body: Faker::Restaurant.description,
                 coordinates: "#{rand(27.499168...27.616584)}, #{rand(53.867102...53.929929)}" }
      Bar.create(params)
      add_comments_to_db(iter)
    end
  end

  def self.add_comments_to_db(iter)
    5.times do |_i_com|
      Comment.create(body: Faker::Restaurant.review,
                     rate: rand(1...5),
                     user_id: rand(1...10),
                     bar_id: iter + 1)
    end
  end
end
