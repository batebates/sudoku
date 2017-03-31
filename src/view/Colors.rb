class Colors
    def Colors.toGdkColor(r, g, b)
        return Gdk::Color.new(r * 65535, g * 65535, b * 65535);
    end

    CL_BLANK = Colors.toGdkColor(1,1,1);
    CL_HIGHLIGHT = Colors.toGdkColor(0.81,0.92,0.92);
    CL_HIGHLIGHT_LINE = Colors.toGdkColor(0.88,1,1);
    CL_HIGHLIGHT_SQUARE = Colors.toGdkColor(0.90,0.80,1);
    CL_NUMBER_LOCKED = Colors.toGdkColor(0.5,0,0);
    CL_NUMBER = Colors.toGdkColor(0.5,0.5,0.5);
    CL_HIGHLIGHT_METHOD = Colors.toGdkColor(0.25,0.75,0.1)
end
