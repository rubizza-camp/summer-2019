<<<<<<< HEAD
def version_ints(version)
  version.split('.').map(&:to_i)
end
=======
# :reek:UtilityFunction
def version_ints(version)
  version.split('.').map(&:to_i)
end
# :reek:NilCheck
>>>>>>> master

def at_least_ruby_version(version)
  vints = version_ints(version)
  ruby_vints = version_ints(RUBY_VERSION)
<<<<<<< HEAD
  vints.zip(ruby_vints).all? { |v, rv| v.nil? || rv.nil? || v >= rv }
end

=======
  vints.zip(ruby_vints).all? { |versions, rv| versions.nil? || rv.nil? || versions >= rv }
end
>>>>>>> master
require 'rspec/given'

describe '#version_ints' do
  Then { version_ints('1.2') == [1, 2] }
  Then { version_ints('2.1.20') == [2, 1, 20] }
end

describe 'at_least_ruby_version' do
  Then { at_least_ruby_version('2') }
  Then { at_least_ruby_version('2.0') }
  Then { at_least_ruby_version('2.0.1') }
  Then { at_least_ruby_version('2.1') }
  Then { at_least_ruby_version('2.1.3.4.1') }

  Then { !at_least_ruby_version('1.9') }
  Then { !at_least_ruby_version('1.9.9.9.9') }
end
