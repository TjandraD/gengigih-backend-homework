require_relative 'person'

jin = Person.new('Jin Sakai', 100, 50)
puts jin

khotun = Person.new('Khotun Khan', 500, 50)
puts khotun

while jin.is_alive && khotun.is_alive
    jin.attack(khotun)
    puts khotun

    khotun.attack(jin)
    puts jin
    
    if !jin.is_alive
        puts "#{jin.name} dies"
    elsif !khotun.is_alive
        puts "#{khotun.name} dies"
    end
end