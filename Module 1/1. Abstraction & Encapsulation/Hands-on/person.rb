class Person
    attr_accessor :hitpoint
    attr_reader :name

    def initialize(name, hitpoint, attack_damage)
        @name = name
        @hitpoint = hitpoint
        @attack_damage = attack_damage
    end

    def to_s
        "#{@name} has #{@hitpoint} hitpoint and #{@attack_damage} attack damage"
    end

    def attack(other_person)
        other_person.take_damage(@attack_damage)
        puts "#{@name} attacks #{other_person.name} with #{@attack_damage} damage"
    end

    def take_damage(damage)
        @hitpoint -= damage
    end

    def is_alive
        return @hitpoint > 0
    end
end