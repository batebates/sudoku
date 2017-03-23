class ConfigEntry
    attr_reader :name, :displayName, :type, :value;

    def initialize(name, displayName, type, value)
        @name = name;
        @displayName = displayName;
        @type = type;
        @value = value;
    end

    def clone()
        return new ConfigEntry(@name, @displayName, @type, @value);
    end
end
