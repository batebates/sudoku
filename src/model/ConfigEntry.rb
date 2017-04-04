class ConfigEntry
    attr_reader :name, :displayName, :type
    attr_accessor :value, :newValue

    def initialize(name, displayName, type, value)
        @name = name;
        @displayName = displayName;
        @type = type;
        @value = value;
        @newValue = 0;
    end

    def clone()
        return ConfigEntry.new(@name, @displayName, @type, @value);
    end
end
