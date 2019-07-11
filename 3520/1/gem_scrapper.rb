require 'mechanize'

mechanize = Mechanize.new

# page = mechanize.get('https://rubygems.org/gems/') # + 'gemname from file'

page = mechanize.get('https://rubygems.org/gems/sinatra/')

test_link = page.link_with(id: 'code').click

def used_by(link)
  #/html/body/div[4]/div/main/div[1]/div/ul/li[1]/a
end

def watch(link)
  # /html/body/div[4]/div/main/div[1]/div/ul/li[2]/form/a
end

def star(link)
  # /html/body/div[4]/div/main/div[1]/div/ul/li[3]/div/form[2]/a
end

def fork(link)
  # /html/body/div[4]/div/main/div[1]/div/ul/li[4]/a
end

def contributors(link)
  # /html/body/div[4]/div/main/div[2]/div[1]/div[2]/div/div/ul/li[4]/a/span
end

def issues(link)
  # /html/body/div[4]/div/main/div[1]/nav/span[2]/a/span[2]
end
