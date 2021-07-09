require_relative 'hero'
require_relative 'mongol'
require_relative 'person'
require_relative 'villain'

jin = Hero.new("Jin Sakai", 100, 50, true)
yuna = Hero.new("Yuna", 90, 45, false)
ishikawa = Hero.new("Sensei Ishikawa", 80, 60, false)

mongol_archer = MongolArcher.new("Mongol Archer", 80, 40)
mongol_spearman = MongolSpearman.new("Mongol Spearman", 120, 60)
mongol_swordsman = MongolSwordsman.new("Mongol Swordsman", 100, 50)

allies = [jin, yuna, ishikawa]
villains = [mongol_archer, mongol_spearman, mongol_swordsman]

i = 1
until (jin.die? || villains.empty?) do
    puts "========== Turn #{i} =========="
    puts "\n"

    allies.each do |ally|
        puts ally
    end
    puts "\n"

    villains.each do |villain|
        puts villain
    end
    puts "\n"

    allies.each do |ally|
        ally.pick_choices(villains, allies) if ally.can_control
    end

    villains.each do |villain|
        villains.delete(villain) if villain.die? || villain.flee?
    end

    allies.each do |ally|
        ally.attack(villains[rand(villains.size)]) if !ally.can_control
        villains.each do |villain|
            villains.delete(villain) if villain.die? || villain.flee?
        end
        break if villains.empty?
    end

    puts "\n"

    villains.each do |villain|
        villain.attack(allies[rand(allies.size)])
        allies.each do |ally|
            allies.delete(ally) if ally.die?
        end
        break if allies.empty?
    end
    puts "\n"

    i += 1
end