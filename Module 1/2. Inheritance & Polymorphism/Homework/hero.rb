require_relative 'person'

class Hero < Person
    def initialize(name, hitpoint, attack_damage, deflect_probability)
        super(name, hitpoint, attack_damage)
        @deflect_probability = deflect_probability
    end

    def deflect_attack?
        current_percentage = rand(100) # generate a random number between 0 and 99
        if current_percentage < @deflect_probability
            return true
        else
            return false
        end
    end

    def take_damage(damage)
        if deflect_attack?
            puts "#{@name} deflects the attack"
        else
            @hitpoint -= damage
        end
    end
end