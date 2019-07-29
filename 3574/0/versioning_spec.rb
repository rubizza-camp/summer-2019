# rubocop: disable Lint/MissingCopEnableDirective, Style/StringLiterals, Style/SymbolProc
# :reek:UncommunicativeVariableName and :reek:UtilityFunction

def version_ints(version)
  version.split(".").map { |v| v.to_i }
end
# :reek:NilCheck and :reek:UncommunicativeVariableName

def at_least_ruby_version(version)
  vints = version_ints(version)
  ruby_vints = version_ints(RUBY_VERSION)
  # :reek:NilCheck:
  vints.zip(ruby_vints).all? { |vin, rvin| vin.nil? || rvin.nil? || vin >= rvin }
end

require 'rspec/given'

describe "#version_ints" do
  Then { version_ints("1.2") == [1, 2] }
  Then { version_ints("2.1.20") == [2, 1, 20] }
end

describe 'at_least_ruby_version' do
  Then { at_least_ruby_version('2') }
  Then { at_least_ruby_version('2.0') }
  Then { at_least_ruby_version('2.0.1') }
  Then { at_least_ruby_version('2.1') }
  Then { at_least_ruby_version('2.1.3.4.1') }

  Then { !at_least_ruby_version("1.9") }
  Then { !at_least_ruby_version("1.9.9.9.9") }
end
