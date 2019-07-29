require 'faker'

# :reek:NestedIterators and :reek:TooManyStatements
# rubocop:disable Metrics/MethodLength
# rubocop:disable Metrics/AbcSize
module Seeds
  def self.call
    20.times do |iter|
      params = {
        id: iter + 1, title: Faker::Name.name,
        short_description: Faker::Restaurant.type,
        full_description: Faker::Restaurant.description,
        coordinates: "#{rand(27.499168...27.616584)}, #{rand(53.867102...53.929929)}"
      }

      Bar.create!(params)

      5.times do |_i_com|
        Review.create(comment: Faker::Restaurant.review,
                      rating: rand(1...5),
                      user_id: rand(1...10),
                      bar_id: iter + 1)
      end
    end
    User.create(email: 'test@test.com', password: 'test')
    puts 'Create 20 bars'
    puts 'Create 100 reviews'
    puts 'Created User => email: \'test@test.com\', password:\'test\''
  end
end
# rubocop:enable Metrics/MethodLength
# rubocop:enable Metrics/AbcSize
