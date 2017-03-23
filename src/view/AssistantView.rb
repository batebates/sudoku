class AssistantView
    private_class_method :new;

    @assistantText

    def AssistantView.init(parent)
        new(parent);
    end

    def initialize(parent)
        SudokuAPI.API.add_observer(self);
        # Split container in 2 parts : Left (Avatar), Right (Speech bubble)
        assistantGrid = Gtk::Grid.new();

        assistantGrid.set_hexpand(true);
        assistantGrid.set_vexpand(true);

        avatarImage = Gtk::Image.new(:file => AssetManager.assetsResource("assistant.png"));

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

        speechBox.add(speechBoxInternal);

        assistantGrid.attach(avatarImage, 0, 0, 1, 1);
        assistantGrid.attach(speechBox, 1, 0, 1, 1);
        parent.attach(assistantGrid, 0, 1, 1, 1);
    end

    def update(type, message)
        if(type == "assistant")
            @assistantText.label = message;
        end
    end
end
