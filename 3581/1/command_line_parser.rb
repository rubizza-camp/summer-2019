require 'optparse'

class CommandLineParser
  class << self
    def read_args
      add_args = { 'file' => 'gems.yml' }
      OptionParser.new do |arg|
        pass_params(arg, add_args)
      end.parse!
      add_args
    end

    def find_gem_by_name(hash_gems, add_args)
      hash_gems.select! { |name, _| name.include?(add_args['name']) }
    end

    private

    def pass_params(arg, add_args)
      arg.on('-t', '--top = t', Integer) { |count| add_args['top'] = count }
      arg.on('-n', '--name = n', String) { |gem_name| add_args['name'] = gem_name }
      arg.on('-f', '--file = f', String) { |file_name| add_args['file'] = file_name }
    end
  end
end
