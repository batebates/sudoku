class AssistantView
    private_class_method :new;

    @assistantText
    @avatarImage

    def AssistantView.init(parent)
        new(parent);
    end

    def initialize(parent)
        @updateTextThread = nil;
        SudokuAPI.API.add_observer(self);
        # Split container in 2 parts : Left (Avatar), Right (Speech bubble)
        assistantGrid = Gtk::Box.new(:horizontal, 0);

        assistantGrid.set_hexpand(true);
        assistantGrid.set_vexpand(true);

        @avatarImage = Gtk::Image.new(:file => AssetManager.assetsResource("assistant.png"));

        # Speech bubble
        speechBox = Gtk::Box.new(:horizontal);
        speechBoxInternal = Gtk::Box.new(:vertical);
        speechBoxInternal.override_background_color(:normal, Gdk::RGBA.new(1,1,1,1));
        speechBoxInternal.set_margin_top(10);
        speechBoxInternal.set_margin_bottom(10);
        speechBoxInternal.name = "assistant_speech_box";

        @assistantText = Gtk::Label.new("Bonjour, je suis l'assistant, je suis là pour vous aider");
        @assistantText.set_margin_top(4);
        @assistantText.set_margin_left(4);
        @assistantText.set_margin_bottom(4);
        @assistantText.set_margin_right(4);
        @assistantText.set_line_wrap(true);
        speechBoxInternal.add(@assistantText);

        speechBox.pack_start(speechBoxInternal, :expand => true, :fill => true, :padding => 0);
        assistantGrid.pack_start(@avatarImage, :expand => false, :fill => false, :padding => 0);
        assistantGrid.pack_start(speechBox, :expand => true, :fill => true, :padding => 0);
        parent.attach(assistantGrid, 0, 2, 1, 1);
    end

    def update(type, message)
        if(type == "assistant")
            @assistantText.label = "";

            if(@updateTextThread != nil)
                @updateTextThread.exit();
            end

            @updateTextThread = Thread.new(){
                length = message.length;
                for i in 0..length
                    @assistantText.label += message[i];
                    sleep(0.05);
                end
            }
        end
    end
end
