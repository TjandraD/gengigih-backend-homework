require_relative 'villain'

class MongolArcher < Villain
    def attack(other_person)
        puts "#{@name} shoots an arrow at #{other_person.name} with #{@attack_damage} damage"
        other_person.take_damage(@attack_damage)
    end
end

class MongolSpearman < Villain
    def attack(other_person)
        puts "#{@name} thrusts #{other_person.name} with #{@attack_damage} damage"
        other_person.take_damage(@attack_damage)
    end
end

class MongolSwordsman < Villain
    def attack(other_person)
        puts "#{@name} slashes #{other_person.name} with #{@attack_damage} damage"
        other_person.take_damage(@attack_damage)
    end
end