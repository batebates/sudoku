class ScoreDialog

	@scoreDialog
	@mainVB

	@scoreList

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

	def initScore()
		hBox = Gtk::Box.new(:horizontal,0)
		pseuLab = Gtk::Label.new("Pseudo")
		scoLab = Gtk::Label.new("Score")

		hBox.pack_start(pseuLab, :expand=>true, :fill=>true, :padding=>2)
		hBox.pack_start(scoLab, :expand=>true, :fill=>false, :padding=>2)
		
		hBox.name = "scoreHeader"

		@mainVB.pack_start(hBox)

		#score load
		sCore = ScoreTable.build()
		sCore.scoreLoad()
		@scoreList = sCore.scores()
		#end load


		for aka in @scoreList
			@mainVB.pack_start(createScoreLine(aka))
		end

	end

	def createScoreLine(score)
		hBox = Gtk::Box.new(:horizontal,2)
		hBox.name = "score"

		pseuLab = Gtk::Label.new(score.getNom)
		scoLab = Gtk::Label.new(score.getScore.to_s)

		hBox.pack_start(pseuLab, :expand=>true, :fill=>true, :padding=>2)
		hBox.pack_start(scoLab, :expand=>true, :fill=>false, :padding=>2)

		return hBox
	end

end