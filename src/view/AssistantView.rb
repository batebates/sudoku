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

        assistantGrid.attach(avatarImage, 0, 0, 1, 1);
        parent.attach(assistantGrid, 0, 1, 1, 1);
    end
end
