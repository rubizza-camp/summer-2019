require './main'
require './setuper'
require './info_source'
require './table_drawer'
Main.new(Setuper, InfoSource, TableDrawer).run
