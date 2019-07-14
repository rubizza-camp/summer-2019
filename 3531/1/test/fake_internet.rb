class FakeInternet
  def open(url)
    case url
    when %r{http://github.com/rails/rails}
      File.open('test/pages/home.html')
    when %r{https://github.com/rails/rails/network/dependents}
      File.open('test/pages/used_by.html')
    else
      raise "unknown url: #{url}"
    end
  end
end
