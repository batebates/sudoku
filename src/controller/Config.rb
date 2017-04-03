class Config
    private_class_method :new
    @@entryList = [];

    def Config.registerConfigs()
        Config.addEntry(ConfigEntry.new("avatar", "Avatar du profil ?", "avatar", "professor"));
        Config.addEntry(ConfigEntry.new("grid_color", "Couleur de la grille", "color", Colors::CL_BLANK));
        Config.addEntry(ConfigEntry.new("hover_color", "Couleur de la case survolée", "color", Colors::CL_HIGHLIGHT));
        Config.addEntry(ConfigEntry.new("hover_line_color", "Couleur de la ligne / colonne survolée", "color", Colors::CL_HIGHLIGHT_LINE));
        Config.addEntry(ConfigEntry.new("hover_square_color", "Couleur du carré survolé", "color", Colors::CL_HIGHLIGHT_SQUARE));
        Config.addEntry(ConfigEntry.new("number_color", "Couleur des chiffres", "color", Colors::CL_NUMBER));
        Config.addEntry(ConfigEntry.new("number_color_locked", "Couleur des chiffres vérouillés", "color", Colors::CL_NUMBER_LOCKED));
        Config.addEntry(ConfigEntry.new("show_line_highlight", "Surligner la ligne / colonne survolée ?", "bool", false));
        Config.addEntry(ConfigEntry.new("show_square_highlight", "Surligner le carré survolé ?", "bool", false));
        Config.addEntry(ConfigEntry.new("show_hint", "Afficher les valeurs possibles ?", "bool", false));
    end

    def Config.addEntry(entry)
        @@entryList.push(entry);
    end

    def Config.getValue(key)
        @@entryList.each { |value|
            if(value.name == key)
                return value.value;
            end
        }
        return nil;
    end

    def Config.entries()
        return @@entryList;
    end

    def Config.set(entryList)
        @@entryList = entryList;
    end

    def Config.save()

    end

    def Config.load()

    end
end
