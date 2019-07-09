require File.expand_path(File.dirname(__FILE__) + '/neo')
  # :reek:RepeatedConditionalClear
  # :reek:NilCheck

class AboutSandwichCode < Neo::Koan
  # :reek:UtilityFunction
  def count_lines(file_name)
    file = File.open(file_name)
    count = 0
    count += 1 while file.gets
    count
  ensure
    file&.close if file
  end

  def test_counting_lines
    assert_equal 4, count_lines('example_file.txt')
  end
  # :reek:UtilityFunction

  def find_line(file_name)
    file = open(file_name)
    while (line = file.gets)
      return line if line =~ /e/
    end
  ensure
    file&.close if file
  end

  def test_finding_lines
    assert_equal "test\n", find_line('example_file.txt')
  end

  def file_sandwich(file_name)
    file = File.open(file_name)
    yield(file)
  ensure
    file&.close if file
  end

  # Now we write:

  def count_lines2(file_name)
    file_sandwich(file_name) do |file|
      count = 0
      count += 1 while file.gets
      count
    end
  end

  def test_counting_lines2
    assert_equal 4, count_lines2('example_file.txt')
  end

  def find_line2(file_name)
    # Rewrite find_line using the file_sandwich library function.
    file_sandwich(file_name) do |file|
      while (line = file.gets)
        return line if line =~ /e/
      end
    end
  end

  def test_finding_lines2
    assert_equal "test\n", find_line2('example_file.txt')
  end
  # :reek:UtilityFunction
  def count_lines3(file_name)
    open(file_name) do |file|
      count = 0
      count += 1 while file.gets
      count
    end
  end

  def test_open_handles_the_file_sandwich_when_given_a_block
    assert_equal 4, count_lines3('example_file.txt')
  end
end
