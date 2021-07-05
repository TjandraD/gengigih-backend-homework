require_relative 'person'

jin = Person.new('Jin Sakai', 100, 50)
puts jin
puts

khotun = Person.new('Khotun Khan', 500, 50)
puts khotun
puts

def both_alive(jin, khotun)
    if jin.is_alive && khotun.is_alive
        return true
    else
        return false
    end
end

while both_alive(jin, khotun)
    jin.attack(khotun)
    puts khotun
    puts

    if !both_alive(jin, khotun)
        break
    end

    khotun.attack(jin)
    puts jin
    puts
end

if !jin.is_alive
    puts "#{jin.name} dies"
elsif !khotun.is_alive
    puts "#{khotun.name} dies"
end