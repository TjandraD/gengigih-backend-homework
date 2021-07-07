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
        if deflect_attack? and other_person.name == "Jin Sakai"
            puts "#{@name} attacks #{other_person.name} with #{@attack_damage} damage"
            puts "#{other_person.name} deflects the attack"
        else
            other_person.take_damage(@attack_damage)
            puts "#{@name} attacks #{other_person.name} with #{@attack_damage} damage"
        end
    end

    def take_damage(damage)
        @hitpoint -= damage
    end

    def is_alive
        return @hitpoint > 0
    end

    def deflect_attack?
        current_percentage = rand(100) # generate a random number between 0 and 99
        if current_percentage < 80
            return true
        else
            return false
        end
    end
end