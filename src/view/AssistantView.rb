require "gtk3"
require "../model/AssetManager.rb"

class AssistantView
    private_class_method :new;

    def AssistantView.init(parent)
        new(parent);
    end

    def initialize(parent)
        # Split container in 2 parts : Left (Avatar), Right (Speech bubble)
        assistantGrid = Gtk::Grid.new();

        assistantGrid.set_hexpand(true);
        assistantGrid.set_vexpand(true);

        avatarImage = Gtk::Image.new(:file => AssetManager.assetsResource("assistant.png"));

        # Speech bubble
        speechBox = Gtk::Box.new(:horizontal);
        speechArrowImage = Gtk::Image.new(:file => AssetManager.assetsResource("speech_arrow.png"));
        speechBoxInternal = Gtk::Box.new(:vertical);
        speechBoxInternal.override_background_color(:normal, Gdk::RGBA.new(1,1,1,1));
        speechBoxInternal.set_margin_top(10);
        speechBoxInternal.set_margin_bottom(10);

        assistantText = Gtk::Label.new("Bonjour, je suis l'assistant");
        assistantText.set_margin_top(4);
        assistantText.set_margin_bottom(4);
        assistantText.set_margin_left(4);
        assistantText.set_margin_right(4);
        speechBoxInternal.add(assistantText);

        speechBox.add(speechArrowImage);
        speechBox.add(speechBoxInternal);

        assistantGrid.attach(avatarImage, 0, 0, 1, 1);
        assistantGrid.attach(speechBox, 1, 0, 1, 1);
        parent.attach(assistantGrid, 0, 1, 1, 1);
    end
end
