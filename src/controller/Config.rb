class Config
    private_class_method :new
    @@entryList = [];

    def Config.registerConfigs()
        Config.addEntry(ConfigEntry.new("grid_color", "Couleur de la grille", "color", Colors::CL_BLANK));
        Config.addEntry(ConfigEntry.new("hover_color", "Couleur de la case survolée", "color", Colors::CL_HIGHLIGHT));
        Config.addEntry(ConfigEntry.new("hover_line_color", "Couleur de la ligne / colonne survolée", "color", Colors::CL_HIGHLIGHT_LINE));
        Config.addEntry(ConfigEntry.new("hover_square_color", "Couleur du carré survolé", "color", Colors::CL_HIGHLIGHT_SQUARE));
        Config.addEntry(ConfigEntry.new("number_color", "Couleur des chiffres", "color", Colors::CL_NUMBER));
        Config.addEntry(ConfigEntry.new("number_color_locked", "Couleur des chiffres vérouillés", "color", Colors::CL_NUMBER_LOCKED));
        Config.addEntry(ConfigEntry.new("show_line_highlight", "Surligner la ligne / colonne survolée ?", "bool", true));
        Config.addEntry(ConfigEntry.new("show_square_highlight", "Surligner le carré survolé ?", "bool", false));
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
    #La liste de config clonée et modifiée via le Dialog
        configSaveFile = File.new("save_files/config.yml","w")
        
        if(!configSaveFile.closed?)
            puts "Fichier de configuration ouvert\n"
        end

        @@entryList.each{ |conf|
            saveConf = conf.clone();
            if(saveConf.type == "color")
                saveConf.value = [saveConf.value.red, saveConf.value.green, saveConf.value.blue];
            end
            configSaveFile.puts YAML::dump(saveConf)
            configSaveFile.puts ""
        }   
        configSaveFile.close

        if(configSaveFile.closed?)
            puts "Sauvegarde de la configuration terminée"
        end

    end

    def Config.load()
        aa = Array.new
        configLoadFile = File.open("save_files/config.yml","r").each do |ob|
            aa << YAML::load(ob)
        end

        configLoadFile.close

        puts aa
    end
end
