class ScoreDialog

	@scoreDialog
	@mainVB

	@scoreList
	@list

	def ScoreDialog.init()
		new()
	end

	def initialize()
		@scoreDialog = Gtk::Dialog.new(:parent => Window.window(), :title => "Tableau des Scores", :flags => [:modal, :destroy_with_parent])
		@scoreDialog.set_default_size(300,500)

		@scoreDialog.add_button("Quitter",Gtk::ResponseType::OK)
		@scoreDialog.set_default_response(Gtk::ResponseType::CANCEL)
	
		@mainVB = Gtk::Box.new(:vertical, 2)
		@mainVB.name = "mainVB"

		#Init
		initList()
		initScore()
		#End Init

		@scoreDialog.child.add(@mainVB)
		@scoreDialog.child.show_all
		CSSStyle.apply_style(@scoreDialog)

		result = @scoreDialog.run

		case result
		when Gtk::ResponseType::OK
			p "Score quit"
			@scoreDialog.destroy
		when Gtk::ResponseType::CLOSE
			@scoreDialog.destroy
		end

	end

	def initList
		scrollWin = Gtk::ScrolledWindow.new
		scrollWin.set_policy(:automatic,:automatic)
		
		@list = Gtk::ListStore.new(String, String)

		pseuCol = Gtk::TreeViewColumn.new("Pseudo",Gtk::CellRendererText.new,{:text=>0})
		scoCol = Gtk::TreeViewColumn.new("Score",Gtk::CellRendererText.new,{:text=>0})

		scoCol.set_sort_column_id(0)
		pseuCol.set_sort_column_id(0)

		treeView = Gtk::TreeView.new(@list)

		treeView.append_column(pseuCol)
		treeView.append_column(scoCol)

		treeView.selection.set_mode(:single)

		scrollWin.add_with_viewport(treeView)
		@mainVB.pack_start(scrollWin)
	end

	def initScore
		sC = ScoreTable.build()
		sC.scoreLoad()
		cp = 1;

		@scoreList = sC.scores()
		p @list
		@scoreList.each { |sc|

			@list.append.set_value(,sc.getScore.to_s)
			cp+=1
		}
	end

end