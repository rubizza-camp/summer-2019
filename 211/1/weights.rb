# NAME    | USED BY | WATCHED BY | STAR  | FORK  | CONTRIBUTORS | OPEND ISSUES | CLOSED ISSUES
# --------|---------|------------|-------|-------|--------------|--------------|--------------
# rails   | 1173065 | 2608       | 43599 | 17526 | 3837         | 372          | 12381        
# rspec   | 316338  | 96         | 2536  | 202   | 21           | 1            | 12           
# sinatra | 144266  | 406        | 10617 | 1905  | 361          | 69           | 639      

p hash_g= {:rails_g => { :used_by => 1173065, :watch => 2608, :star => 43599, :fork => 17526, :contr => 3837, :op_iss => 372, :cl_iss => 12381},
:rspec_g => { :used_by => 316338 , :watch => 96  , :star => 2536 , :fork => 202  , :contr => 21  , :op_iss => 1  , :cl_iss => 12   },
:sinat_g => { :used_by => 144266 , :watch => 406 , :star => 10617, :fork => 1905 , :contr => 361 , :op_iss => 69 , :cl_iss => 639  }}

# arr = [rails_g,rspec_g, sinat_g]

# arr.each {|gem_n| puts  gem_n[:used_by]}

# weights = {:used_by => 9 , :watch => 5 , :star => 8, :fork => 10 , :contr => 1 , :op_iss => 1 , :cl_iss => 7  }


# нормализация критериев
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
# ashn.each do |k,v|
# 	ashn[k] = [v.max, v.min]
# end

hash_g.each do |k,vh|
		vh.each do |k1,v1|
		vh[k1] = normalise(v1, ashn[k1].min,  ashn[k1].max )
	end
end

p hash_g
# class Hash
#   def normalise!(d0,d1)
#   	ar = self.values
#     xMin,xMax = ar.minmax
#     dx = d1-d0
#     xrange = (xMax-xMin).to_f
#     self.each {|k,x| self[k] =  (d0 + dx * (x-xMin) / xrange).round(2) }

#   end
# end

# # a = [3.0, 6.0, 3.1416]
# # a.normalize!
# # => [0.0, 1.0, 0.047199999999999985]

# criteria = {:used_by => {} , :watch => {} , :star => {}, :fork => {} , :contr => {} , :op_iss => {} , :cl_iss => {}  }

# criteria.each do |cr,hsh|
#   arr.each do |gemn|
#   hsh[gemn[:name]] = gemn[cr]
#   end
# end


# p criteria

# # criteria.each do |cr, ar|
# # 	xmin = ar.min
# # 	xmax = ar.max
# # 	normalized_arr = []
# # 	ar.each do |crit|
# # 	  normalized_arr << normalise(crit, xmin, xmax)
# # 	end
# # 	p normalized_arr
# # 	p criteria[cr] = normalized_arr

# # end

# # puts
# # p criteria

# criteria.each do |cr, hsh|
# 	criteria[cr] = hsh.normalise!(0,1 )
# end

# p criteria

weights = {:used_by => 10 , :watch => 4 , :star => 8, :fork => 6 , :contr => 0 , :op_iss => 0 , :cl_iss => 2  }
puts
hash_g.each do |g, cr|
	cr.each do |k,v|
		cr[k] = v*weights[k]
	end
end
puts hash_g

# criteria.each do |cr, hsh|
# 	criteria[cr] = hsh.each {|ge, num| hsh[ge] = (num * weights[cr]).round(3) }
# end

# def transp(hsh)
#   hsh.inject({}) do |a,(k,v)|
#     v.inject(a) do |a1,(k1,v1)|
#       a1[k1] ||= {}
#       a1[k1][k] = v1
#       a1
#     end
#   end
# end
# puts
# puts

# p criteria_new = transp(criteria)

def summarize(hsh)
  hsh.each do |k,v|
  	hsh[k] =  v.values.reduce(:+)
  end
end
puts
puts
p summarize(hash_g)