require './main'
require './setuper'
require './repo_adapter'
require './table_drawer'
Main.new(Setuper, RepoAdapter, TableDrawer).run
