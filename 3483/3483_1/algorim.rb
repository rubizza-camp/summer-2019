class Algoritm
	def get_points(mass)
		(0...mass.size).each do |i|
     	mass[i] <<" #{mass[i][1].split(' ').last.to_i * 
                      mass[i][2].split(' ').last.to_i * 
                      mass[i][3].split(' ').last.to_i}  Yan Points"
        end
	end 

		def vivod(mass)
			(0...mass[0].size).each do |i|
				puts "#{i} place #{mass[0][i][0]}\n #{mass[0][i]}"
			end
			
		end
	

	def get_top(mass)
		watt = []
		get_points(mass)
		watt << mass.sort_by {|elem| elem[9].split(' ').first.to_i}.reverse
		vivod(watt)
	end
end