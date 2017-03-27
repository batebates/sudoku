class CSSStyle
    private_class_method :new

    def CSSStyle.init()
        new();
    end

    def initialize()
        @@provider = Gtk::CssProvider.new();
        @@provider.load(:path  => AssetManager.assetsResource("theme.css"));
        CSSStyle.apply_style(Window.window());
    end

    def CSSStyle.apply_style(widget)
        style_context = widget.style_context
        style_context.add_provider(@@provider, Gtk::StyleProvider::PRIORITY_USER)
        return unless widget.respond_to?(:children)
        widget.children.each do |child|
            apply_style(child)
        end
    end
end
