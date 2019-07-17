require_relative 'terminal_parser.rb'

selector = TerminalParser.do_terminal_parse
Table.fetch_table_output(selector)
