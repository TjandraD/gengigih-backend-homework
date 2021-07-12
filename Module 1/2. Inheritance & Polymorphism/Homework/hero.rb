require_relative 'person'

class Hero < Person
    attr_reader :can_control

    def initialize(name, hitpoint, attack_damage, can_control)
        super(name, hitpoint, attack_damage)
        @deflect_probability = 0.8
        @can_control = can_control
        @heal_point = 20
        @initial_hitpoint = hitpoint
    end

    def deflect_attack?
        if rand < @deflect_probability
            return true
        else
            return false
        end
    end

    def take_damage(damage)
        if deflect_attack?
            puts "#{@name} deflects the attack"
        else
            super(damage)
        end
    end

    def pick_choices(villains, allies)
        puts "As #{@name}, what do you want to do this turn?"
        puts "1) Attack an enemy"
        puts "2) Heal an ally"
        choice = gets.to_i
        puts "\n"

        if choice == 1
            pick_attack(villains)
        elsif choice == 2
            pick_heal(allies)
        else
            puts "Please pick a valid option"
            pick_choices(villains, allies)
        end
    end

    def pick_attack(villains)
        puts "Which enemy you want to attack?"
        villains.each_with_index do |villain, index|
            puts "#{index + 1}) #{villain.name}"
        end

        choice = gets.to_i
        puts "\n"
        if choice <= villains.size
            attack(villains[choice - 1])
        else
            puts "Please pick a valid option"
            pick_attack(villains)
        end
    end

    def pick_heal(allies)
        puts "Which ally you want to heal?"
        allies.each_with_index do |ally, index|
            puts "#{index}) #{ally.name}" if ally != self
        end

        choice = gets.to_i
        puts "\n"
        if choice <= allies.size
            heal_ally(allies[choice])
        else
            puts "Please pick a valid option"
            pick_heal(allies)
        end
    end

    def heal
        @hitpoint += @heal_point
        @hitpoint = @initial_hitpoint if @hitpoint > @initial_hitpoint
    end

    def heal_ally(other_person)
        puts "#{@name} heals #{other_person.name}, restoring #{@heal_point} hitpoints"
        other_person.heal
    end
end