class AssetManager

    def AssetManager.assetsPath()
        return File.absolute_path(File.dirname(__FILE__) + "/../../assets");
    end

    def AssetManager.assetsDir()
        return AssetManager.assetsPath() + "/";
    end

    def AssetManager.assetsResource(path)
        return AssetManager.assetsDir() + path;
    end
end
