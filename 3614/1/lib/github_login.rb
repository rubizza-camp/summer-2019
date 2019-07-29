class GithubLogin
  def initialize
    @agent = Mechanize.new
  end

  LOGIN_URL = 'https://github.com/login'.freeze

  def auth
    @agent.get(LOGIN_URL)

    loop do
      break if set_form.title.eql?('GitHub')

      puts 'Wrong username or password, please try again'
    end
    @agent
  end

  def set_form
    form = @agent.page.forms[0]
    form['login'] =  get_data_from_console('username')
    form['password'] = get_data_from_console('password')
    form.submit
  end

  def get_data_from_console(text)
    puts "Write #{text}"
    STDIN.noecho(&:gets).chomp
  end
end
