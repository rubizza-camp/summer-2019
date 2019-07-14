# NAME    | USED BY | WATCHED BY | STAR  | FORK  | CONTRIBUTORS | OPEND ISSUES | CLOSED ISSUES
# --------|---------|------------|-------|-------|--------------|--------------|--------------
# rails   | 1173065 | 2608       | 43599 | 17526 | 3837         | 372          | 12381        
# rspec   | 316338  | 96         | 2536  | 202   | 21           | 1            | 12           
# sinatra | 144266  | 406        | 10617 | 1905  | 361          | 69           | 639      

p hash_g= {:rails_g => { :used_by => 1173065, :watch => 2608, :star => 43599, :fork => 17526, :contr => 3837, :op_iss => 372, :cl_iss => 12381},
:rspec_g => { :used_by => 316338 , :watch => 96  , :star => 2536 , :fork => 202  , :contr => 21  , :op_iss => 1  , :cl_iss => 12   },
:sinat_g => { :used_by => 144266 , :watch => 406 , :star => 10617, :fork => 1905 , :contr => 361 , :op_iss => 69 , :cl_iss => 639  }}

def normalise(x, xmin, xmax, d0=0, d1=1)
  xrange = xmax - xmin
  drange = d1 - d0
  normalized = (d0 + (x - xmin) * (drange.to_f / xrange) ).round(2)
end

ashn = {}
hash_g.each do |k, vh|
  vh.each do |k1,v1|
    ashn[k1] ||= []
    ashn[k1] << v1
  end
end
p ashn 

hash_g.each do |k,vh|
    vh.each do |k1,v1|
    vh[k1] = normalise(v1, ashn[k1].min,  ashn[k1].max )
  end
end

p hash_g

weights = {:used_by => 10 , :watch => 4 , :star => 8, :fork => 6 , :contr => 0 , :op_iss => 0 , :cl_iss => 2  }
puts "++++++++++++++"
hash_g.each do |g, cr|
	cr.each do |k,v|
		cr[k] = v*weights[k]
	end
	hash_g[g] =  cr.values.reduce(:+)
end
puts "++++++++++++++++++"
puts hash_g


