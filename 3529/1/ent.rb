class FakeInternet
  def get(url)
    case url
    when %r(github.com/rails/rails)
      File.load('tests/pages/github-rails.html')
    when %r(rubygems.org/gem/rails)
      File.load('tests/pages/rubygems-rails.html')
    else
      raise "I don't known about URL: #{url}"
    end
  end
end
​
class RealInternet
  def get(url)
    URI.open(url)
  end
end
​
class MyClass
  def initalize(internet = RealInternet.new)
    @internet = internet
    # ....
  end
​
  def action
    @internet.get('http://github.com/rails/rails')
    # ...
  end
end
