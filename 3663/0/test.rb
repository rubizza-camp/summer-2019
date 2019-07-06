def score(dice)
  score = 0

  # dice.sort.each_with_index do |step, index|
  #   if step == 1
  #     p 'got one'
  #     if dice[index] == dice[index + 1] && dice[index] == dice[index + 2]
  #       score += step * 1000
  #       p 'got 3 ones'
  #     else
  #       score += step * 100
  #     end
  #   end

  #   if step == 5
  #     score += step * 10
  #     p 'got five'
  #   end
  # end

  if dice.sort.to_s.include?('1, 1, 1')
    score += 1000
    dice.sort.each_with_index do |step, index = 3|
      p index
      if step == 1
        score += step * 100
      end

      if step == 5
        score += step * 10
      end
    end
  end

  score
end

p score([1, 1, 1, 5, 1])
