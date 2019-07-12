# NAME    | USED BY | WATCHED BY | STAR  | FORK  | CONTRIBUTORS | OPEND ISSUES | CLOSED ISSUES
# --------|---------|------------|-------|-------|--------------|--------------|--------------
# rails   | 1173065 | 2608       | 43599 | 17526 | 3837         | 372          | 12381        
# rspec   | 316338  | 96         | 2536  | 202   | 21           | 1            | 12           
# sinatra | 144266  | 406        | 10617 | 1905  | 361          | 69           | 639      

rails_g = {:used_by => 1173065, :watch => 2608, :star => 43599, :fork => 17526, :contr => 3837, :op_iss => 372, :cl_iss => 12381}
rspec_g = {:used_by => 316338 , :watch => 96  , :star => 2536 , :fork => 202  , :contr => 21  , :op_iss => 1  , :cl_iss => 12   }
sinat_g = {:used_by => 144266 , :watch => 406 , :star => 10617, :fork => 1905 , :contr => 361 , :op_iss => 69 , :cl_iss => 639  }

arr = [rails_g,rspec_g, sinat_g]

# arr.each {|gem_n| puts  gem_n[:used_by]}

# weights = {:used_by => 9 , :watch => 5 , :star => 8, :fork => 10 , :contr => 1 , :op_iss => 1 , :cl_iss => 7  }


#нормализация критериев
def normalise(x, xmin, xmax, d0=0, d1=1)
  xrange = xmax - xmin
  drange = d1 - d0
  d0 + (x - xmin) * (drange.to_f / xrange) 
end

criteria = {:used_by => [] , :watch => [] , :star => [], :fork => [] , :contr => [] , :op_iss => [] , :cl_iss => []  }

criteria.each do |cr, ar|
  arr.each do |gemn|
  	ar << gemn[cr]
  end
end

puts criteria

# xmin = arr_used.min
# xmax = arr_used.max

# arr_used.each do |u|
# 	puts normalise(u, xmin, xmax)
# end

criteria.each do |cr, ar|
	xmin = ar.min
	xmax = ar.max
	normalized_arr = []
	ar.each do |crit|
	  normalized_arr << normalise(crit, xmin, xmax)
	end
	p normalized_arr
	p criteria[cr] = normalized_arr

end

puts
p criteria
