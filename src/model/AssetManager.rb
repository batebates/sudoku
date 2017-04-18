#===Permet de récuperer des ressources simplement
class AssetManager

    #===Retourne le chemin vers le dossier des ressources
    def AssetManager.assetsPath()
        return File.absolute_path(File.dirname(__FILE__) + "/../../assets");
    end

    #===Retourne le chemin vers le dossier des ressources sous forme de dossier
    def AssetManager.assetsDir()
        return AssetManager.assetsPath() + "/";
    end

    #===Retourne une ressources depuis le dossier de ressources
    def AssetManager.assetsResource(path)
        return AssetManager.assetsDir() + path;
    end
end
