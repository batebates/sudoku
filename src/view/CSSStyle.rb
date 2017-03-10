require "gio2"
require "gtk3"
require "pango"

class CSSStyle
    private_class_method :new

    def CSSStyle.init()
        new();
    end

    def initialize()
        @provider = Gtk::CssProvider.new();
        @provider.load(:path  => AssetManager.assetsResource("theme.css"));
        apply_style(Window.window(), @provider);
    end

    def apply_style(widget, provider)
        style_context = widget.style_context
        style_context.add_provider(provider, Gtk::StyleProvider::PRIORITY_USER)
        return unless widget.respond_to?(:children)
        widget.children.each do |child|
            apply_style(child, provider)
        end
    end
end
