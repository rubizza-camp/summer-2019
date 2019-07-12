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


class Array
  def normalise!(d0,d1)
    xMin,xMax = self.minmax
    dx = d1-d0
    xrange = (xMax-xMin).to_f
    self.map! {|x| (d0 + dx * (x-xMin) / xrange).round(2) }
  end
end

criteria = {:used_by => [] , :watch => [] , :star => [], :fork => [] , :contr => [] , :op_iss => [] , :cl_iss => []  }

criteria.each do |cr, ar|
  arr.each do |gemn|
  	ar << gemn[cr]
  end
  ar.normalise!(0,1)
end

p criteria

