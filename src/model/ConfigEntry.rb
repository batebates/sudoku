class ConfigEntry
    attr_reader :name, :displayName, :type
    attr_accessor :value

    def initialize(name, displayName, type, value)
        @name = name;
        @displayName = displayName;
        @type = type;
        @value = value;
    end

    def clone()
        return ConfigEntry.new(@name, @displayName, @type, @value);
    end
end
