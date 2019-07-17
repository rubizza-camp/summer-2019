This gems popularity programs consists of two 5 files:
1. Gemfile - all you need for install gem bundle
2. Gemfile.lock - don't touch it!!!
3. Gems.yaml - file with list of gems will used in programs.
4. filters.rb - module Filters that consist of methods that used with flags -n, -t and popularity sort method.
5. top_gems.rb - program file - interface is in method called 'run', other methods are private.

Flags: 
-f, --file - You can run it if you want to run alternative file. This flag use on yaml file. example: run top_gems.rb -f /desktop/ruby/gems.yaml
-n, --name - Filter all gems by text pattern. It is regex sensetive, that means that if you enter run top_gems.rb -n 'act' - you will get all ruby gems that contains in name pattern 'act'
-t, --top - Filter number of gems that you want to output. You will get n of gems that are sort by popularity. example: run top_gems.rb -t 3 (you will get 3 most popular gem from list)